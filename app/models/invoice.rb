  class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  enum status: { "in progress": 0, completed: 1, cancelled: 2 }

  def self.unshipped_invoices
    joins(:invoice_items)
    .where.not(invoice_items: {status: 2})
    .distinct
  end

  def self.successful_transactions_count
    sum do |invoice|
      invoice.transactions.where(result: 0).count
    end
  end

  def self.sort_by_date
    order(:created_at)
  end

  def self.best_day
    where(invoices: {status: :completed})
    .group(:id)
    .select('invoices.created_at, invoices.id, count(invoices.id) as sales')
    .order('sales desc, created_at')
    .first
  end

  def total_revenue_of_invoice
    items.total_revenue_of_all_items
  end

  def discount_revenue
    items.joins(merchant:[:bulk_discounts])
    .where('invoice_items.quantity >= bulk_discounts.threshold')
    .sum('(invoice_items.unit_price - (invoice_items.unit_price * bulk_discounts.discount)) * invoice_items.quantity')
    # items.joins(merchant:[:bulk_discounts])
    # .where('invoice_items.quantity >= bulk_discounts.discount')
    # .select('merchants.id, max((invoice_items.unit_price - (invoice_items.unit_price * bulk_discounts.discount)) * invoice_items.quantity) as d_revenue')
    # .group('merchants.id')
    # .sum(&:d_revenue)
  end
end
