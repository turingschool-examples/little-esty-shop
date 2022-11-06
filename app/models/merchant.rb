class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, -> { distinct }, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :name

  enum status: { disabled: 0, enabled: 1 }

  def top_merchant_transactions
    Customer
      .joins(invoices: [:transactions, { items: :merchant }])
      .where("transactions.result = 0 AND merchants.id = #{id}")
      .select('customers.*, count(transactions) AS transactions_count')
      .group('id')
      .order(transactions_count: :desc)
      .limit(5)
  end

  def items_ready_to_ship
    items
      .joins(invoice_items: :invoice)
      .where('invoice_items.status = 0 OR invoice_items.status = 1')
      .select('items.*, invoices.created_at AS invoice_date, invoices.id AS invoice_id')
      .order(:created_at)
  end

  def top_items_by_revenue
    items
      .joins(invoices: :transactions)
      .where('transactions.result = 0')
      .select('items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS item_revenue')
      .group(:id)
      .order(item_revenue: :desc)
      .limit(5)
  end

  def self.enabled_merchants
    where('status = 1')
  end

  def self.disabled_merchants
    where('status = 0')
  end
end
