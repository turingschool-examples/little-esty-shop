class Merchant < ApplicationRecord
  enum status: {enabled: 0, disabled: 1}
  validates :name, presence: true
  validates :status, presence: true


  has_many :items

  def self.merchant_invoices(merchant_id)
    Invoice.select("invoices.*, COUNT(merchants.*) AS merchant_count,
       COUNT(items.*) AS item_count")
       .joins("INNER JOIN invoice_items ON invoices.id = invoice_items.invoice_id")
       .joins("INNER JOIN items ON invoice_items.item_id = items.id")
       .joins("INNER JOIN merchants ON items.merchant_id = merchants.id")
       .where("merchants.id = ?", merchant_id)
       .group(:id)
       .order(Arel.sql("item_count DESC LIMIT 10"))
  end

  def self.order_by_enabled
    where("status = 0")
  end

  def self.order_by_disabled
    where("status = 1")
  end


  def status_opposite
    status == 'enabled' ? 'disabled' : 'enabled'
  end

  def top_five_items
    items.joins(invoices: :invoice_items)
    .joins("INNER JOIN transactions ON invoices.id = transactions.invoice_id")
    .select("items.*, sum(invoice_items.unit_price * invoice_items.quantity) AS total_item_price")
    .group(:id)
    .where("transactions.result = ?", 0)
    .order("total_item_price DESC")
    .limit(5)
  end
end
