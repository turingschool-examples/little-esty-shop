class InvoiceItem < ApplicationRecord
  enum status: [ 'packaged', 'pending', 'shipped' ]
  belongs_to :item
  belongs_to :invoice_items
end
