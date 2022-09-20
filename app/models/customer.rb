class Customer < ApplicationRecord
  has_many :invoices

  has_many :transactions, through: :invoices

  def self.top_customers
    joins(:transactions)
    .where('result = ?', 1)
    .group(:id)
    .select("customers.*, count('transactions.result') as transaction_count")
    .order(transaction_count: :desc)
    .limit(5)
  end
end
