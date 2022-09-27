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

  def total_revenue_merchant(merch_id)
    items.joins(:invoice_items)
    .where('items.merchant_id = ?', merch_id)
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def discount_amount_merchant(merch_id)
    invoice_items.joins(:bulk_discounts)
    .where('invoice_items.quantity >= bulk_discounts.threshold AND bulk_discounts.merchant_id = ?', merch_id)
    .select('invoice_items.*, max((invoice_items.quantity * invoice_items.unit_price) * bulk_discounts.discount) as discount')
    .group(:id)
    .sum(&:discount)
  end

  def revenue_with_discount(merch_id)
    total_revenue_merchant(merch_id) - discount_amount_merchant(merch_id)
  end
end
