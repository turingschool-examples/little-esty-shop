class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def unshipped
    items.joins(invoice_items: :invoice)
    .select('invoices.id as invoice_id, invoices.created_at as invoice_created, name')
    .where.not('invoice_items.status = ?', 2)
    .distinct
    .order('invoices.created_at DESC')
  end

  def items_by_status_true
    items.where(status: true)
  end

  def items_by_status_false
    items.where(status: false)
  end

  def top_5_items_by_revenue
    items.joins(invoices: :transactions)
    .select("items.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .where("transactions.result = ?", 0)
    .group("items.id")
    .order(revenue: :desc).limit(5)
  end

  def top_days_by_item
    
  end
end
