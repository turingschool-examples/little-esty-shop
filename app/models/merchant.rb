class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :invoice_items, through: :items
   
  def merchant_invoices
    invoices.distinct.order(:id)
  end

  def items_not_yet_shipped
    invoices.order(created_at: :asc)
    invoice_items.where.not(status: "shipped")
  end
  
  def top_5_items_by_revenue
    items.joins(invoice_items: {invoice: :transactions}).where(transactions: {result: 0}).group(:id).select('items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue').order('total_revenue DESC').limit(5)
  end
end
