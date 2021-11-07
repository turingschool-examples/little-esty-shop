class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices, source: :invoice_items
  has_many :transactions, through: :invoices

  validates_presence_of :name 

  def top_customers
    Transaction.joins(invoice: :customer)
    .where("result =?", 0)
    .where("status =?", 1)
    .select("customers.*, count(transactions.id) as top_count")
    .group("customers.id")
    .order(top_count: :desc)
    .limit(5)
  end
end