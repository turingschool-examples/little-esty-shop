class Merchant < ApplicationRecord
  enum status: {enabled: 0, disabled: 1}

  validates :name, presence: true
  validates :status, presence: true

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :discounts


  def self.top_merchants_by_revenue
    select("merchants.id, merchants.name AS merchant_name,
      COUNT(transactions.*) AS transaction_count,
      SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
      .joins("INNER JOIN items ON merchants.id = items.merchant_id")
      .joins("INNER JOIN invoice_items ON items.id = invoice_items.item_id")
      .joins("INNER JOIN invoices ON invoice_items.invoice_id = invoices.id")
      .joins("INNER JOIN transactions ON invoices.id = transactions.invoice_id")
      .joins("INNER JOIN customers ON invoices.customer_id = customers.id")
      .where("transactions.result = ?", 0)
      .group(:id)
      .order(total_revenue: :desc)
      .limit(5)
  end

  def self.merchant_invoices(merchant_id)
    Invoice.select("invoices.*, COUNT(merchants.*) AS merchant_count,
     COUNT(items.*) AS item_count")
     .joins("INNER JOIN invoice_items ON invoices.id = invoice_items.invoice_id")
     .joins("INNER JOIN items ON invoice_items.item_id = items.id")
     .joins("INNER JOIN merchants ON items.merchant_id = merchants.id")
     .where("merchants.id = ?", merchant_id)
     .group(:id)
     .order(item_count: :desc)
  end

  def self.order_by_enabled
    where(status: 0)
    .order(:name)
  end

  def self.order_by_disabled
    where(status: 1)
    .order(:name)
  end

  def status_opposite
    status == 'enabled' ? 'disabled' : 'enabled'
  end

  def best_day_for_merchant(merchant_id)
    Merchant.select("SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue,
      invoices.created_at AS invoice_date")
      .joins("INNER JOIN items ON merchants.id = items.merchant_id")
      .joins("INNER JOIN invoice_items ON items.id = invoice_items.item_id")
      .joins("INNER JOIN invoices ON invoice_items.invoice_id = invoices.id")
      .joins("INNER JOIN transactions ON invoices.id = transactions.invoice_id")
      .where("transactions.result = ?", 0)
      .where(id: merchant_id)
      .group(:invoice_date)
      .order(total_revenue: :desc, invoice_date: :desc)
      .limit(1)
      .first
  end

  def top_five_items
    items.joins(invoices: :invoice_items)
    .joins("INNER JOIN transactions ON invoices.id = transactions.invoice_id")
    .select("items.*, sum(invoice_items.unit_price * invoice_items.quantity) AS total_item_price")
    .where("transactions.result = ?", 0)
    .group(:id)
    .order(total_item_price: :desc)
    .limit(5)
  end

  def discount_names
    discounts.map(&:name)
  end

end
