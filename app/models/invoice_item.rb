class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  validates :quantity, :unit_price, :status, :created_at, :updated_at, presence: true
end
