class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  enum status: [:packaged, :pending, :shipped]

  def item_revenue
    quantity * unit_price
  end
end
