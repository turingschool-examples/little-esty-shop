class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :name
  validates :enabled, inclusion: { in: [ true, false ] }

  def ready_to_ship
    items
    .select("items.*, invoice_items.status, invoices.created_at")
    .joins( :invoices )
    .where.not("invoice_items.status = ?", 2)
    .order('invoices.created_at')
  end

  def self.top_5_revenue
   select('merchants.name, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
   .joins(:invoice_items)
   .group(:id)
   .order('revenue desc')
   .limit(5)
  end

  def top_day
    invoices.joins(:transactions)
    .where('transactions.result = 1')
    .select('DATE(invoices.created_at) as creation, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .group('creation')
    .order('revenue desc, creation desc')
    .first
    .creation
  end

  def favorite_customers
    items.select("customers.*, count(transactions.result) as transaction_count")
    .joins(invoices:[:transactions, :customer])
    .where(transactions: {result: 1})
    .group('customers.id')
    .order('transaction_count desc')
    .limit(5)
  end


  def self.top_5_revenue
    select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue').joins(:transactions).where(transactions: {result: 1}).group(:id).order('revenue desc').limit(5)
  end

  def total_revenue
    select('invoices.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue')
    .where('invoice_items.status = 2')
    .joins(items:[:invoice_items, :invoices])
    .group('invoices.id')
  end

  def top_5_items
    items
    .joins(invoices: :transactions)
    .where(transactions: {result: 1})
    .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .group('items.id')
    .order('revenue desc')
    .limit(5)
  end
end
