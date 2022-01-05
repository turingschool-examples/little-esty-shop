class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  validates :quantity, :unit_price, :status, presence: true
  enum status: { pending: 1, packaged: 2, shipped: 3 }
end
