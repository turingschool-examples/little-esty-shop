class Customer < ApplicationRecord
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :transactions, through: :invoices

  def self.top_five_customers
    joins(:transactions)
    .where('transactions.result = ?', 0)
    .group('customers.id')
    .select("customers.*, count(*) AS transaction_count")
    .order(transaction_count: :desc)
    .limit(5)
  end

  def successful_transactions
    transactions
    .where('result = ?', 0)
    .count
  end
end
