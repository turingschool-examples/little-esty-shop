class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  def self.group_by_status(status)
    where(status: status)
  end

  def self.top_five_revenue
    joins(invoices: [:transactions, :invoice_items])
    .where("transactions.result = 0")
    .select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue")
    .group(:id)
    .order(total_revenue: :desc)
    .limit(5)
  end

  def total_revenue
    invoice_items.sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def highest_revenue_date
    invoices
    .joins(:invoice_items)
    .select("invoices.created_at, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue")
    .group("invoices.created_at")
    .order(total_revenue: :desc)
    .first
    .created_at
    .strftime("%A, %B %d, %Y")
  end
end
