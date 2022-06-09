class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :discounts, through: :merchants

  validates_presence_of :first_name, :last_name

  def self.top_customers
    joins(invoices: :transactions)
    .where(transactions: {result: true})
    .group(:id).select("customers.*, COUNT(transactions) AS transaction_count")
    .order("transaction_count desc")
    .limit(5)
  end
end
