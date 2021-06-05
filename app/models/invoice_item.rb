# app/models/invoice_items

class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  def self.item_details
    joins(:items).select("invoice_items.*, items.name as name, invoice_items.unit_price as price, invoice_items.status as status")
  end
end
