class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  validates :quantity, :unit_price, :status, presence: true
end
