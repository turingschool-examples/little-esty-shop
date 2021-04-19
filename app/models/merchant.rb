class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  scope :enable, -> { where(status: true) }
  scope :disable, -> { where(status: false) }

  def enable_merchant
    update(status: true)
  end

  def disable_merchant
    update(status: false)
  end


  def invoice_items_ready_to_ship
    invoice_items.where.not(status: :shipped)
   .joins(:invoice)
   .where('invoices.status = ?', Invoice.statuses[:completed])
   .order('invoices.created_at')
  end

  def self.top_merchants
    joins(:transactions)
    .where('transactions.result = ?', 0)
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .group('merchants.id')
    .order(total_revenue: :desc)
    .limit(5)
  end

  def best_day
    invoices
    .joins(:invoice_items)
    .group('invoices.created_at')
    .select('invoices.created_at AS created_at, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .order(total_revenue: :desc)
    .first
    .format_time

  end
end
