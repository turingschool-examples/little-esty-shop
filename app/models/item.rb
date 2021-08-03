class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  def best_sales_day
    invoices.joins(:transactions)
    .where(transactions: {result: true})
    .select("invoices.created_at as best_day, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .group("invoices.id")
    .order(revenue: :desc)
    .first
    .best_day
  end
end
