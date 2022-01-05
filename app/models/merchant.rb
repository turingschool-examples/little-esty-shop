class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
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
    items.joins(:invoice_items)
    .where.not("invoice_items.status = ?", 2)
  end
end
