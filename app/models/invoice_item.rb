class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  enum status: [:packaged, :pending, :shipped]

  def item_revenue
    # InvoiceItem.group(:id).sum(quantity * unit_price)
    quantity * unit_price
  end
end
