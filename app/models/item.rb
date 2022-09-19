class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def item_best_day
    invoices.select(:created_at, "invoice_items.unit_price * invoice_items.quantity as revenue").order("revenue desc").first.created_at
  end
end
