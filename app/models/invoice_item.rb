class InvoiceItem < ApplicationRecord
  enum status: { pending: 0, shipped: 1, packaged: 2}
  # default: :pending

  validates_presence_of :quantity
  validates_presence_of :unit_price
  validates_presence_of :status
  validates_presence_of :created_at
  validates_presence_of :updated_at
  validates_presence_of :item_id
  validates_presence_of :invoice_id

  belongs_to :invoice
  belongs_to :item
end
