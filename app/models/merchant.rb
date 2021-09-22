class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, through: :items
  has_many :customers, through: :invoices

  validates :name, presence: true

  def self.enabled_merchants
    where(status: true)
  end

  def self.disabled_merchants
    where(status: false)
  end

  def merchant_invoices
    Invoice.joins(:items).where("items.merchant_id = ?", id)
  end

  def enabled
    items.where(status: 1)
  end

  def disabled
    items.where(status: 0)
  end

  def packaged_items
    items.joins(:invoice_items).where.not('invoice_items.status = ?', 2)
  end

  def five_best_customers
    customers.joins(invoices: :transactions)
             .where(transactions: {result: :success})
             .group('customers.id')
             .select('customers.*')
             .order(count: :desc)
             .limit(5)
  end

  def top_five_items
    items.joins(invoices: :transactions)
        .where(transactions: {result: :success})
        .group('items.id')
        .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS item_revenue')
        .order(item_revenue: :desc)
        .limit(5)
  end

  def item_best_day
    def item_best_day
     invoices.where(invoice_items: {item_id: id})
             .order(quantity: :desc)
             .first.created_at.strftime("%m/%d/%y")
   end
  end
end
