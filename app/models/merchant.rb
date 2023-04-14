class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def top_5_customers
    customers.joins(:transactions)
    .where(transactions: {result: 'success'})
    .select("customers.*, count(DISTINCT transactions.id) as transaction_count")
    .group("customers.id")
    .order("transaction_count desc").limit(5)
  end
  
  def top_5_items
    items.select("items.*, unit_price * count(*) AS revenue")
    .joins(:invoice_items)
    .group("items.id").
    order("unit_price * count(*) desc").limit(5)
  end
end