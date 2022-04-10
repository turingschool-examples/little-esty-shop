class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  validates :quantity, presence: true
  validates :unit_price, presence: true, numericality: true

  enum status: {pending: 0, packaged: 1, shipped: 2}
end
