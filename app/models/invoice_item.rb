# app/models/invoice_items

class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
end