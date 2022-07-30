class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def top_five_items
    items.joins(:transactions)
    .where(invoices: {status: 2}, transactions: {result: 'success'})
    .select("items.id, items.name, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .group(:id)
    .order("revenue desc")
    .limit(5)
  end

  def self.top_five_merchants
     self.joins(:transactions)
    .where(invoices: {status: 2}, transactions: {result: 'success'})
    .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .group(:id)
    .order("revenue desc")
    .limit(5)
  end

  def favorite_customers
    customers.joins(invoices: :transactions)
    .select("customers.*, count(transactions.id) as transactions_count")
    .group("customers.id")
    .where(transactions: {result: 0}, invoices:{status: 2})
    .order(transactions_count: :desc)
    .limit(5)
  end

  def ready_to_ship
    items.joins(invoices: :invoice_items)
    .where(invoice_items: {status: 1})
    .select("items.*, invoices.created_at as date_created")
    .order("invoices.created_at ASC").distinct
  end
end
