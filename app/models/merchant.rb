class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :customers, through: :invoices

  def top_5_customers
    self.customers.order(transaction_count: :desc).limit(5)
  end
end