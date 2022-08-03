class InvoiceItem < ApplicationRecord
  enum status: { packaged: 0, pending: 1, shipped: 2}
  # default: :pending

  validates_presence_of :quantity
  validates_presence_of :unit_price
  validates_presence_of :status
  validates_presence_of :item_id
  validates_presence_of :invoice_id

  belongs_to :invoice
  belongs_to :item

end
