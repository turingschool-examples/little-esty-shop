class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity, :unit_price, :item_id, :invoice_id
  
  enum status: ['packaged', 'pending', 'shipped']
  
  belongs_to :item
  belongs_to :invoice
end
