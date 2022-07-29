class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  # Top 5 customers by transaction count
  def self.top_customers
    joins(invoices: :transactions)
      .select('customers.*, count(transactions.result) AS transaction_total')
      .where(transactions: { result: 1 })
      .group(:id)
      .distinct
      .order(transaction_total: :desc)
      .limit(5)
  end
end
