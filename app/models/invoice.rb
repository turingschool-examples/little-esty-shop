class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items, dependent: :destroy
  has_many :transactions, dependent: :destroy

  validates_presence_of :status

  def total_revenue
    invoice_items.sum('unit_price * quantity') * 0.01.to_f
  end

  def incomplete?
    invoice_items.where.not(status: 'shipped').count > 0
  end
end
