class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_customers
    customers.joins(:transactions)
             .where(transactions: {result: 'success'})
             .select("customers.*, count(DISTINCT transactions.id) as transaction_count")
             .group("customers.id")
             .order("transaction_count desc").limit(5)
  end
end