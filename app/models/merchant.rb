class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices,  through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :name

  def merchant_invoice_by_item_id
    InvoiceItem.all.where(item_id: items.ids).pluck(:invoice_id).uniq
  end

  def self.merchant_revenue
    joins(invoice_items: :transactions)
    .where(transactions: {result: 'success'})
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .group(:id)
    .order(revenue: :desc)
    .limit(5)
  end

  def invoice_rev(merchant_id)
    invoice_items
    .joins(:item)
    .where(items: { merchant_id: merchant_id })
    .sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def merchant_best_day
    invoices.joins(:transactions)
    .where(transactions: {result: 'success'})
    .group(:id)
    .select('invoices.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue')
    .order(revenue: :desc)
    .first.updated_at
  end
end
