class Customer < ApplicationRecord
  has_many :invoices

  
  def self.top_five_customers
    select('customers.*, count(transactions) AS transaction_count')
    .joins(invoices: :transactions)
    .where(transactions: {result: 1})
    .group(:id)
    .order('transaction_count DESC')
    .limit(5)
  end
end
