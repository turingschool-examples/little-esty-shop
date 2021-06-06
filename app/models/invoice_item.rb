# app/models/invoice_items

class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  enum status: { pending: 0, packaged: 1, shipped: 2 }

  def self.total_revenue 
    sum("invoice_items.unit_price * invoice_items.quantity")
  end
end
