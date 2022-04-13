class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def top_five_customers
    customers.select("customers.*, count(transactions) as transaction_count")
             .joins(invoices: :transactions)
             .where(transactions: {result: 'success'})
             .group(:id).order(transaction_count: :desc)
             .limit(5)
  end
end
