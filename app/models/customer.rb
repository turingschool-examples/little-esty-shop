class Customer < ApplicationRecord

  has_many :invoices
  has_many :transactions, through: :invoices

  def self.top_customers
    joins(:transactions)
    .where('result = ?', 1)
    .group(:id)
    .select("customers.*, count('transactions.result') as top_result")
    .order(top_result: :desc)
    .limit(5)
  end

  def number_of_transactions
    transactions
    .where('result = ?', 1)
    .count
  end
end
