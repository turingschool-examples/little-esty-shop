class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  def unshipped_invoice_items
    items.select('items.name, invoice_items.invoice_id, invoice_items.status, invoice_items.id AS invoice_item_id, invoices.created_at AS invoice_created_at')
    .where("invoice_items.status = 0 OR invoice_items.status = 1")
    .joins(:invoices)
    .order('invoices.created_at')
  end
end
