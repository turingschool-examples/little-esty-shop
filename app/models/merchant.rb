class Merchant < ApplicationRecord
  validates :name, presence: true
  
  enum status: ["Enabled", "Disabled"]
  
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def top_five_merchant_customers
    self.customers
      .joins(invoices: :transactions)
      .select("customers.*, count('transactions.id') as total_purchases")
      .where(transactions: {result: 0})
      .group(:id)
      .order(count: :desc)
      .limit(5)
  end

  def invoice_items_ready_to_ship
    self.invoice_items
    .joins(:invoice)
    .where(status: "packaged")
    .order(created_at: :asc)
  end

  def top_five_merchant_items
    self.items
    .joins(:invoice_items => { :invoice => :transactions })
    .where('transactions.result = ?', Transaction.results[:success])
    .group('items.id')
    .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .order('revenue DESC')
    .limit(5)
  end
  def self.enabled_merchants
    self.where(status: "Enabled")
  end
  
  def self.disabled_merchants
    self.where(status: "Disabled")
  end

  def self.top_five_merchants_by_revenue
    self.joins(:transactions)
      .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
      .where(transactions: {result: 0})
      .group(:id)
      .order(revenue: :desc)
      .limit(5)
  end

  def top_day_by_revenue
    self.invoices.joins(:transactions)
      .select("invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) as daily_revenue")
      .where(transactions: {result: 0})
      .group("invoices.created_at")
      .order(daily_revenue: :desc, created_at: :desc)
      .first
  end
end
