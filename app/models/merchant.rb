class Merchant < ApplicationRecord
  has_many :items

  def enabled_items 
    items.where(status: "enabled")
  end

  def disabled_items 
    items.where(status: "disabled")
  end

  def top_five_items
    items.joins(invoices: :transactions)
    .where(transactions: {result: "success"})
    .group(:id)
    .select("items.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue")
    .order(total_revenue: :desc)
    .limit(5)
  end
end