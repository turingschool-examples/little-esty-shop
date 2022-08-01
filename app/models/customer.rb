class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name

  has_many :invoices

  def self.top_five_customers
    joins(invoices: :transactions)
    .select("customers.*, count(transactions.id) as transactions_count")
    .where(transactions: {result: 0})
    .group("customers.id")
    .order(transactions_count: :desc)
    .limit(5)
  end
end
