class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  enum status: [ :cancelled, :'in progress', :completed ]

  def self.incomplete
    where.not(status: 2)
  end

  def self.ordered_by_dated
    order(:created_at)
  end

  def total_revenue
    invoice_items.sum('quantity * unit_price')
  end
end
