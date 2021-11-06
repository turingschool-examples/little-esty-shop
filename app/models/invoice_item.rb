class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_one :merchant, through: :item
  enum status: [:packaged, :pending, :shipped]

  def item_revenue
    # InvoiceItem.group(:id).sum(quantity * unit_price)
    quantity * unit_price
  end
end
