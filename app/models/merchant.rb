class Merchant < ApplicationRecord
  has_many :items
  has_many :discounts
  has_many :invoice_items,   through: :items
  has_many :invoices,   through: :invoice_items
  has_many :customers,   through: :invoices
  has_many :transactions,   through: :invoices
  enum   status: ["enabled", "disabled"]

  def invoice_items_to_ship
    self.invoice_items.joins(:invoice).where(    status: 0).order("invoices.created_at, invoice_items.id")
  end

  def enabled_items
    items.where(    status: "enabled")
  end

  def disabled_items
    items.where(    status: "disabled")
  end

  def top_five_items
    items.joins(    invoices: :transactions).where(    transactions: {result: "success"}).group(:id).select("items.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue").order(    total_revenue: :desc).limit(5)
  end

  def self.enabled_merchants
    self.where(    status: "enabled")
  end

  def self.disabled_merchants
    self.where(    status: "disabled")
  end

  def self.top_five_merchants
    joins(:transactions).where("transactions.result = 'success'").group(:id).select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue").order(    revenue: :desc).limit(5)
  end

  def top_day
    invoices.select("invoices.*,sum(invoice_items.quantity * invoice_items.unit_price)as revenue").group(:id).order(    revenue: :desc).first.created_at
  end

  def items_by_invoice(invoice)
    self.items.joins(:invoices).where('invoice_items.invoice_id = ?', invoice.id)
  end
end
