class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  enum status: {"enabled": 0, "disabled": 1}

  def favorite_customers
    customers
    .joins(:transactions)
    .where('transactions.result = ?', 'success')
    .group('customers.id')
    .select('customers.*, count(*) as transaction_count')
    .order('transaction_count desc, last_name, first_name')
    .limit(5)
  end

  def ready_to_ship
    invoice_items
    .joins(:invoice)
    .where.not("invoice_items.status = ?", 2)
    .order("invoices.created_at")
  end

  def find_all_by_status(num)
    items.where(status: num)
  end

  def self.return_by_status_enabled
    where("status = ?", 0)
  end

  def self.return_by_status_disabled
    where("status = ?", 1)
  end

  def five_most_popular_items
    items
    .joins(:invoice_items, :transactions)
    .where('transactions.result = ?', 'success')
    .group('items.id')
    .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .order('revenue desc')
    .limit(5)
  end

  def best_revenue_day
    invoices
    .joins(:transactions)
    .where('transactions.result = ?', 'success')
    .select('invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .group('invoices.created_at')
    .order('revenue desc, invoices.created_at desc')
    .first.created_at.strftime("%m/%d/%y")
  end

  def self.five_top_merchants_by_revenue
    joins(:invoice_items, :transactions)
    .where('transactions.result = ?', 'success')
    .group('merchants.id')
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .order('revenue desc')
    .limit(5)
  end

  def merchant_total_revenue
    items
    .joins(:invoice_items, :transactions)
    .where('transactions.result = ?', 'success')
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end

end
