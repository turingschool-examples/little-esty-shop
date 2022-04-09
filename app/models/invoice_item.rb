class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  enum status: {packaged: 0, pending: 1, shipped: 2}
  validates_presence_of :quantity
  validates_presence_of :status
  validates_presence_of :created_at
  validates_presence_of :updated_at
end
