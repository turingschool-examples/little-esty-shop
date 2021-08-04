class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates :name, presence: true

  scope :enabled_merchants, -> {where(enabled: true)}

  scope :disabled_merchants, -> {where(enabled: false)}

  def enabled_items
    items.where(enabled: 0)
  end

  def disabled_items
    items.where(enabled: 1)
  end


  def best_revenue_day
    items.joins(:transactions)
    .where("transactions.result = ?", 0)
    .select("invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .group("invoices.created_at")
    .order("revenue desc, invoices.created_at desc")
    .first
    .created_at
  end

  def self.top_merchants
    joins(items: {invoice_items: {invoice: :transactions}})
    .group('id')
    .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .where('invoices.status = ?', 2)
    .where('transactions.result = ?', 0)
    .order(Arel.sql('SUM(invoice_items.quantity * invoice_items.unit_price) desc'))
    .limit(5)
  end

  def best_day
    self.items.joins(:invoice_items)
    .joins(:invoices)
    .joins(:transactions)
    .group('invoices.id, items.id')
    .select('invoices.created_at, SUM(invoice_items.quantity * invoice_items.unit_price)')
    .where('invoices.status = ?', 2)
    .where('transactions.result = ?', 0)
    .order(Arel.sql('SUM(invoice_items.quantity * invoice_items.unit_price) desc'))
    .pluck(Arel.sql('invoices.created_at'))
    .first
  end
end

