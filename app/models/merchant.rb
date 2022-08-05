class Merchant < ApplicationRecord
  enum status: { Disabled: 0, Enabled: 1 }

  has_many :items
  has_many :bulk_discounts
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def items_ready_to_ship
    invoice_items.joins(:invoice).where.not(status: 2).order('invoices.created_at')
  end

  def top_five_most_popular_items
    items
      .joins(:transactions)
      .where(transactions: { result: 1 })
      .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
      .group(:id)
      .order(revenue: :desc)
      .limit(5)
  end

  def favorite_customers
    customers.joins(invoices: :transactions)
             .where(transactions: { result: 1 })
             .select('customers.*, count(transactions.result) as transaction_total')
             .group(:id)
             .order(transaction_total: :desc)
             .distinct
             .limit(5)
  end

  def enabled_items
    items.where(status: 'Enabled')
  end

  def disabled_items
    items.where(status: 'Disabled')
  end

  def best_date
    invoices
      .joins(:transactions)
      .where(transactions: { result: 1 })
      .select('invoices.id, invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .group(:id)
      .order(revenue: :desc)
      .limit(1)
      .first
      .formatted_date
  end

  def self.top_5_merchants
    joins(invoices: :transactions)
      .where(transactions: { result: 1 })
      .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .group('merchants.id')
      .order(revenue: :desc)
      .limit(5)
  end

  def self.enabled_merchants
    where(status: 'Enabled')
  end

  def self.disabled_merchants
    where(status: 'Disabled')
  end
end
