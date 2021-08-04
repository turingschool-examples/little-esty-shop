class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def self.enabled_merchants
    where("status = ?", "enabled")
  end

  def self.disabled_merchants
    where("status = ?", "disabled")
  end

  def self.top_5_merchants_revenue
    joins(items: {invoice_items: {invoice: :transactions}})
    .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .group(:id)
    .where(transactions: { result: :success})
    .order(revenue: :desc)
    .limit(5)
  end

  def best_day
    # require "pry"; binding.pry
  end

  def top_five_items
    items.joins(invoices: :transactions)
    .where(transactions: {result: true})
    .select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .group("items.id")
    .order(revenue: :desc)
    .limit(5)
  end

  def ready_to_ship
    invoice_items.joins(:invoice)
    .where(status: ['packaged', 'pending'])
    .select('items.name as item_name, invoice_items.*, invoices.created_at as invoice_date')
    .group('items.id, invoice_items.id, invoices.id')
    .order(:invoice_date)
  end

end
