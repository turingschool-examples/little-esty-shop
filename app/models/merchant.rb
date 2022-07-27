class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def top_5_customers
    Customer
    .joins(:invoices, :transactions)
    .group("customers.id")
    .select("customers.*, count(transactions.id) as no_of_transactions")
    .where(invoices: {status: :completed}, transactions: {result: :success})
    .order("no_of_transactions desc, customers.last_name").limit(5)
  end

end
