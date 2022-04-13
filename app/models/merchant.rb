class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items

  def unshipped_invoice_items
    # Item.find_by_sql("SELECT * FROM merchants INNER JOIN items ON merchants.id = items.merchant_id INNER JOIN invoice_items ON items.id = invoice_items.item_id WHERE merchant_id = ? ", id )
    items.joins(:invoice_items).select('items.name, invoice_items.invoice_id, invoice_items.status, invoice_items.id AS invoice_item_id').where("invoice_items.status = 0 OR invoice_items.status = 1")
  end
end
