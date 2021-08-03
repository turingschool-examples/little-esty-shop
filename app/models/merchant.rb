class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def enabled_items
    items.where(enabled: 0)
  end

  def disabled_items
    items.where(enabled: 1)
  end

  def self.best_revenue_day
    joins(:transactions)
    .where("transactions.result = ?", 0)
    .select("invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .group("invoices.created_at")
    .order("revenue desc, invoices.created_at desc")
    .first
    .created_at
  end
end
