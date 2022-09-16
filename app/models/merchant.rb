class Merchant < ApplicationRecord
  enum status: ["Enabled", "Disabled"]
  validates_presence_of :name
  validates_presence_of :status, inclusion: ["Enabled", "Disabled"]
  has_many :items

  def merchant_invoices
    Invoice.joins(:items).where("items.merchant_id = ?", id).distinct
  end

  def self.enabled_merchants
    Merchant.where(status: 0)
  end

  def self.disabled_merchants
    Merchant.where(status: 1)
  end
  
  def items_sorted_by_revenue
    items.
    joins(:invoice_items).
    select('items.*, sum(invoice_items.quantity *invoice_items.unit_price) as revenue').
    group('items.id').
    order(revenue: :desc)
  end

  def top_five_items
    items_sorted_by_revenue.successful_transactions.limit(5)
  end
end

