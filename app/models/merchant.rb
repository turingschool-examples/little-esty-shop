class Merchant < ApplicationRecord
  has_many :items
  
  # public
  def enabled_items
    items.where(enabled: true)
  end

  def disabled_items
    items.where(enabled: false)
  end

  def top_items
    Item.joins(invoices: :transactions)
    .where("result = 0")
    .select(:name, :id, "sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .group(:id)
    .order(revenue: :desc)
    .limit(5)
  end
end
