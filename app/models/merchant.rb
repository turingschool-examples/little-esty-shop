class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :discounts
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  enum active_status: { disabled: 0, enabled: 1 }

  def items_not_shipped_sorted_by_date
    invoices.where.not(invoice_items: {status: 2}).order("invoices.created_at")
  end

  def self.active
    where(active_status: :enabled)
  end

  def self.inactive
    where(active_status: :disabled)
  end

  def invoices_distinct_by_merchant
    invoices.group(:id).distinct.sort
  end

  def self.top_5_order_by_revenue
    joins(invoices:[:transactions])
    .group(:id)
    .where(transactions: { result: 0 })
    .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue')
    .order('total_revenue desc')
    .limit(5)
  end
end
