class Merchant < ApplicationRecord
  enum status: {enabled: 0, disabled: 1}
  validates :name, presence: true
  validates :status, presence: true

  has_many :items


  def merchant_items
    items.all
  end

  def self.top_merchants_by_revenue
    select("merchants.id, merchants.name AS merchant_name,
      COUNT(transactions.*) AS transaction_count,
      SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
      .joins("INNER JOIN items ON merchants.id = items.merchant_id")
      .joins("INNER JOIN invoice_items ON items.id = invoice_items.item_id")
      .joins("INNER JOIN invoices ON invoice_items.invoice_id = invoices.id")
      .joins("INNER JOIN transactions ON invoices.id = transactions.invoice_id")
      .joins("INNER JOIN customers ON invoices.customer_id = customers.id")
      .where("transactions.result = 0")
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
       # .limit(5)
  end

  def self.order_by_enabled
    where("status = 0")
  end

  def self.order_by_disabled
    where("status = 1")
  end
end
