class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices
  has_many :items, through: :invoices
  validates_presence_of :first_name, :last_name

  def self.top_5_customers
    Customer.joins(invoices: :transactions)
    .where(transactions: { result: "success"})
    .select('customers.*, count(transactions.*) as total_transactions')
    .order(total_transactions: :desc)
    .group(:id)
    .limit(5)
  end
end