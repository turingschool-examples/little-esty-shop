class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  
  enum status: [:enabled, :disabled]

  def item_top_day
    invoices.select('invoices.id as id, invoices.created_at as time, sum(invoice_items.quantity * invoice_items.unit_price)as revenue')
    .group('id')
    .order(revenue: :desc, time: :desc)
    .first
    .time
  end
end
