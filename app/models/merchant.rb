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

  def self.top_merchants
    joins(invoices: :invoice_items)
    .joins(:transactions)
    .select('merchants.name, merchants.id, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .where('transactions.result = ?', 0)
    .group('merchants.id, invoice_items.quantity, invoice_items.unit_price')
    .order(revenue: :desc)
    .limit(5)
  end
end
