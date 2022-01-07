class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def date_with_most_sales
    invoices
    .joins(:invoice_items)
    .select("invoices.created_at, invoice_items.quantity as item_quantity")
    .order(item_quantity: :desc)
    .first
    .created_at
    .strftime("%m/%d/%Y")
  end
end
