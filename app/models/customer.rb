class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name

  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  def self.top_five_customers
    select("customers.*, count(transactions.id) as transactions_count")
    .joins(invoices: :transactions)
    .where(transactions: {result: 0}, invoices:{status: 2})
    .group("customers.id")
    .order(transactions_count: :desc)
    .limit(5)
  end

  def top_5_merchants
    merchants.joins(:transactions)
             .where(transactions: {result: 0})
             .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
             .group('merchants.id')
             .order(revenue: :desc)
             .limit(5)
  end
end
