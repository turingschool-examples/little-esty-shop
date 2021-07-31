class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.enabled_merchants
    where(enabled: true)
  end

  def self.disabled_merchants
    where(enabled: false)
  end

  def enabled_items
    items.where(enabled: 0)
  end

  def disabled_items
    items.where(enabled: 1)
  end

  def self.top_merchants
    # joins(items: :invoice_items)
    # .joins(:transactions)
    select('merchants.name, merchants.id, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .joins(items: {invoice_items: {invoice: :transactions}})
    .where('transactions.result = ?', 0)
    .group('merchants.id')
    .order(revenue: :desc)
    .limit(5)

    # joins(invoices: :transactions).
    # joins(:invoice_items).
    # select('merchants.name, merchants.id, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    # .where('invoices.status = ?', 2)
    # .where('transactions.result = ?', 0)
    # .group('merchants.id, merchants.name, invoices.id')
    # .order(revenue: :desc)
    # .limit(5).distinct
  end
end

Merchant.joins(invoices: :transactions).
joins(:invoice_items).select('merchants.name, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue').where('invoices.status = ?', 2)
.where('transactions.result = ?', 0)
.group('merchants.name, invoices.id')
.order(revenue: :desc)
.limit(5)
