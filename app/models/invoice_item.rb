class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  validates :unit_price, presence: true
  validates :quantity, presence: true

  enum status: {pending: 0, packaged: 1, shipped: 2}

  def self.total_revenue
    sum("invoice_items.unit_price * invoice_items.quantity")
  end
end
