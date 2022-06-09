class Merchant < ApplicationRecord
  has_many :discounts
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true

  enum status: { 'disabled' => 0, 'enabled' => 1 }

  def items_ready_to_ship
    Merchant.joins(invoice_items: [invoice: :transactions])
    .where(merchants: {id: self.id}, invoice_items: {status: [0,2]}, invoices: {status: [1,2]}, transactions: {result: true})
    .select("items.name, invoices.id, invoices.created_at")
    .order("invoices.created_at ASC")
  end

  def top_five_items
    items
    .joins(invoice_items: [invoice: :transactions])
    .where(transactions: {result:true})
    .select("items.*, SUM(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .group(:id)
    .order('revenue desc')
    .limit(5)
  end

  def self.enabled
    where(status: 1)
  end

  def self.disabled
    where(status: 0)
  end

  def top_five_favorite_customers
    customers.joins(invoices: :transactions)
    .where(transactions: { result: true })
    .select('customers.*, count(transactions.*) as transaction_count')
    .group('customers.id')
    .order(transaction_count: :desc)
    .limit(5)
  end

  def self.top_five_merchants_by_revenue
    joins(:invoices, [:transactions, :invoice_items])
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .group(:id)
    .order(revenue: :desc)
    .limit(5)
  end

  def best_day
    invoices
    .joins(:transactions, :invoice_items)
    .where(transactions: {result: true})
    .select('invoices.created_at, sum(invoice_items.unit_price * invoice_items.quantity) as revenue')
    .group(:id)
    .order("revenue DESC", "created_at DESC")
    .first
    .created_at
  end
end
