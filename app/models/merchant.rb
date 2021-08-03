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
    # items.joins(invoice_items: {invoice: :transactions})
    # .group('invoices.id, invoices.created_at')
    # .select('invoices.created_at')
    # .where('transactions.result = ?', 0)
    # .where('merchants.id = ?', id)
    # .order('SUM(invoice_items.quantity * invoice_items.unit_price) desc')
    # .limit(1)

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
# items.joins(:invoice_items)
# .joins(:invoices)
# .group('invoices.id, items.id')
# .select('invoices.created_at, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
# .first.created_at
