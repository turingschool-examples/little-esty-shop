class Merchant < ApplicationRecord
  enum status: ["enabled", "disabled"]

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def top_5_customers
    customers.joins(invoices: :transactions)
    .where('transactions.result = ?', 'success')
    .select("customers.*, count(transactions) as transaction_count")
    .group(:id)
    .order(transaction_count: :desc)
    .limit(5)
  end

  def items_not_shipped
    items.joins(:invoice_items, :invoices)
    .where.not("invoice_items.status = ?", 2)
    .order('invoices.created_at')
  end

  def top_five_items
    items.joins(invoices: [:transactions, :invoice_items])
    .where('transactions.result = ?', 'success')
    .select("items.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue")
    .group(:id)
    .order(total_revenue: :desc)
    .limit(5)
  end

  def self.disabled
    where(status: 1)
  end

  def self.enabled
    where(status: 0)
  end
end
