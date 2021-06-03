# app/models/invoice_items

class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  def self.find_invoice_id(item_id)
    invoice = where("#{item_id} = invoice_items.item_id").pluck(:invoice_id).first
  end
end
