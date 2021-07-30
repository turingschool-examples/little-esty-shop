class Customer < ApplicationRecord
  has_many :invoices

  def self.admin_top_five_customers
    Customer.select("customers.*, count(transactions.invoice_id) as transaction_count")
    .joins(invoices: :transactions)
    .where('transactions.result = 0')
    .group(:id)
    .order('transaction_count DESC')
    .limit(5)
  end
end
