class Merchant < ApplicationRecord
  validates :name, presence: true
  validates :status, presence: true

  has_many :items, dependent: :destroy

  enum status: [ :enabled, :disabled ]

  def ship_ready
    Merchant.joins(items: {invoice_items: :invoice})
      .where("merchants.id = ?", self.id).where("invoices.status != ?", 1).where("invoice_items.status != ?", 2)
      .order("invoices.created_at").pluck("items.name", "invoices.id", "invoices.created_at")
  end

  def top_five_customers
    Merchant.joins(items: {invoice_items: {invoice: {transactions: {invoice: :customer}}}})
        .where("merchants.id = ?", self.id).where("result = ?", 1).limit(5)
        .group('customers.id', 'customers.first_name', 'customers.last_name').order(count: :desc).count
  end

  def self.top_five_by_revenue
    Merchant.joins(items: {invoice_items: {invoice: :transactions}})
    .where("transactions.result = ?", 1)
    .group(:id)
    .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue")
    .order(total_revenue: :desc)
    .limit(5)
  end

  def best_day
    self.items
    .joins(invoice_items: {invoice: :transactions})
    .where("transactions.result = ?", 1)
    .group("invoices.id")
    .select("invoices.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue")
    .order(total_revenue: :desc)
    .first
    .created_at
  end

  def unique_invoices
    Invoice.joins(items: :merchant).where('merchants.id = ?', self.id).group(:id)
  end
end
