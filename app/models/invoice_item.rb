class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  enum status: [:packaged, :pending, :shipped]

  def item_revenue
    # InvoiceItem.group(:id).sum(quantity * unit_price)
    quantity * unit_price
  end

  def self.item_revenue
    group(:item_id).sum('quantity * unit_price')

    # select("items.*, sum(quantity * invoice_items as revenue)")
  end
end
