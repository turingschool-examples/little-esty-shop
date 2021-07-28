class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.top_customers
    select('customers.*, COUNT(transactions.result) AS transaction_count')
    .joins(:invoices, :transactions)
    .where('transactions.result = ?', 0)
    .order('transaction_count DESC, first_name')
    .group(:id)
    .limit(5)
  end
end
