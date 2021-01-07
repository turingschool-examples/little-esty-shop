class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity, :unit_price, :status, :item_id, :invoice_id
  
  belongs_to :item
  belongs_to :invoice
end
