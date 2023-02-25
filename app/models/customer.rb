class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.customers_transactions
    joins(:transactions).group(:id).select("CONCAT(customers.first_name,' ', customers.last_name) AS full_name, COUNT(transactions.result = 0) AS successful_order").order(successful_order: :desc, full_name: :asc).limit(5)
  end
end
