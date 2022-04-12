class InvoiceItem < ApplicationRecord
  enum status: {pending: 0, packaged: 1, shipped: 2}
  validates_presence_of :quantity
  validates_presence_of :unit_price
  validates_presence_of :status
  validates_presence_of :item_id
  validates_presence_of :invoice_id

  belongs_to :item
  belongs_to :invoice
end
