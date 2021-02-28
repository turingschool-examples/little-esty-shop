class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def top_five_customers
    transactions
    .joins(invoice: :customer)
    .where('result = ?', true)
    .select("customers.*, count('transactions.result') as purchases")
    .group('customers.id')
    .order(purchases: :desc)
    .limit(5)
  end
end
