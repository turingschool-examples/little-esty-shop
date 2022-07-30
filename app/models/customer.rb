class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.top_five_by_transaction_count
    joins(:transactions)
    .distinct
    .select('customers.*, count(transactions) AS transaction_count')
    .where(transactions: {result: "success"})
    .group(:id)
    .order(transaction_count: :desc)
    .limit(5)
  end
end
