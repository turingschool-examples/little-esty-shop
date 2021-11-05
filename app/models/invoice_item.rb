class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  enum status: [:packaged, :pending, :shipped]

  def item_revenue
    # InvoiceItem.group(:id).sum(quantity * unit_price)
    quantity * unit_price
  end

  def self.item_revenue_top_five
    revenue = group(:item_id).sum('quantity * unit_price')
    revenue.sort_by{ |_, v| -v }.to_h.keys

    # select("invoice_items.*, sum(quantity * unit_price) as revenue").group(:id).order('item_id DESC, revenue')

    # .keys.sort_by(&:to_i).order('desc').limit(5)

    # select("items.*, sum(quantity * invoice_items as revenue)")
  end
end
