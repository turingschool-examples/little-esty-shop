class Customer < ApplicationRecord
  has_many :invoices
  
  def self.top_5_customers
    Customer.joins(invoices: [:transactions]).group(:id).where(transactions: {result: 0}).select('customers.*, count(result) as success_count').order(success_count: :desc).limit(5)
  end
end
