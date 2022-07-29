class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def favorite_customers
    Customer.joins(invoices: :transactions)
    .select("customers.*, count(transactions.id) as transactions_count")
    .group("customers.id")
    .where(transactions: {result: 0})
    .order(transactions_count: :desc)
    .limit(5)
  end
end
