class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: ['cancelled','in progress', 'completed']

  validates :status, inclusion: { in: statuses.keys }

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def unshipped
    invoice_items.each do |ii|
      self if ii.status != 2
    end
  end
end
