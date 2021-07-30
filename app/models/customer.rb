class Customer < ApplicationRecord
  has_many :invoices

  def self.top_customers(merchant_id)
    select(Arel.sql('count(customers.id) as total_transactions, customers.*'))
    .joins(invoices: :transactions)
    .joins(invoices: :items)
    .where(Arel.sql('transactions.result = 0'))
    .where('items.merchant_id = ?', merchant_id)
    .group(:id).order(Arel.sql('total_transactions desc'))
    .limit(5)
  end
end
