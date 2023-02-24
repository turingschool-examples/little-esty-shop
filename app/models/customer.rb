class Customer < ApplicationRecord
  has_many :invoices

  def self.top_five_customers
    select("customers.*, count('transactions.id') as total_purchases")
      .joins(invoices: :transactions)
      .where(transactions: {result: 0})
      .group(:id)
      .order(count: :desc)
      .limit(5)
  end
end
