class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  validates_presence_of :quantity, :unit_price, :status, :item_id, :invoice_id

  enum status: {pending: 0, packaged: 1, shipped: 2}
end
