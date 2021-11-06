class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def revenue
    invoice_items.sum(&:item_revenue)
  end

  def self.top_5_by_revenue
    select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .joins(:invoice_items)
    .group(:id)
    .order('revenue desc')
    .limit(5)
  end
end


