class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  # def self.top_5_successful_customers
  #   joins(:transactions)
  #   .select("customers.*, COUNT(transactions.id) AS transaction_count")
  #   .where(transactions: {result: 0})
  #   .group(:id)
  #   .order("transaction_count DESC")
  #   .limit(5)
  # end

end
