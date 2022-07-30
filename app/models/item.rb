class Item < ApplicationRecord
  belongs_to :merchant
  enum status:[:disabled, :enabled]
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price

  def self.top_5_by_rev(merchant)
    joins(invoices: :transactions)
      .where(transactions: { result: 0 }, merchant_id: merchant.id)
      .group(:id)
      .select('SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue, items.*')
      .order('revenue desc')
      .limit(5)
  end

  def total_sales
    invoice_items
      .joins(invoice: :transactions)
      .where(transactions: { result: 0 })
      .sum('invoice_items.quantity * invoice_items.unit_price')
      .fdiv(100)
  end

    def top_day
    invoices
      .joins(:invoice_items)
      .select('invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
      .group('invoices.created_at')
      .order('total_revenue desc, invoices.created_at desc')
      .first
      .created_at
      .strftime("%Y-%m-%d")
  end
end
