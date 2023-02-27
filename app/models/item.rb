class Item < ApplicationRecord
  enum status: ["Enabled", "Disabled"]

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.enabled
    where(status: "Enabled")
  end

  def self.disabled
    where(status: "Disabled")
  end

  def item_best_day
    self.invoices.joins(:transactions)
    .where(transactions: {result: 'success'})
    .select("invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) as item_revenue")
    .order(item_revenue: :desc, created_at: :desc)
    .group("invoices.created_at")
    .first
  end
end
