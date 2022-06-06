class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  enum status: %i[disabled enabled]

  def ready_items
    items.joins(:invoices).select('items.*')
         .where('invoice_items.status = 1')
         .group('items.id')
         .distinct
         .order(:created_at)
  end

  def top_five_items_by_revenue
    items.joins(invoice_items: :transactions)
         .where(transactions: {result: 0})
         .group(:id) #item_id
         .select("items.*, sum(quantity * invoice_items.unit_price) as total_revenue")
         .order(total_revenue: :desc)
         .limit(5)
  end

  def self.top_five_merchants_by_revenue
    joins(invoice_items: :transactions)
          .where(transactions: {result: 0})
          .select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue")
          .group(:id)
          .order(total_revenue: :desc)
          .limit(5)
  end
end
