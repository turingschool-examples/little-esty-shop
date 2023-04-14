class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.top_five
    Customer.joins(:transactions)
      .select("CONCAT(customers.first_name, ' ',  customers.last_name) AS full_name, customers.id, COUNT(transactions.id) AS transaction_count")
      .group("customers.id, full_name")
      .order(count: :desc)
      .limit(5)
  end
end