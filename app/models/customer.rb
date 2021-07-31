class Customer < ApplicationRecord
  has_many :invoices

  def self.top_customers(merchant_id)
    select(Arel.sql('count(customers.id) as total_transactions, customers.*'))
    .joins(invoices: :transactions)
    .joins(invoices: :items)
    .where(Arel.sql('transactions.result = 0'))
    .where('items.merchant_id = ?', merchant_id)
    .group(:id).order(Arel.sql('total_transactions desc'))
  end

  def self.admin_top_five_customers 
    Customer.select("customers.*, count(transactions.invoice_id) as transaction_count")
    .joins(invoices: :transactions)
    .where('transactions.result = 0')
    .group(:id)
    .order('transaction_count DESC')
    .limit(5)
  end
end
