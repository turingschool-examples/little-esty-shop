class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  validates :unit_price, numericality: {only_integer: true}, presence: true
  validates :quantity, numericality: {only_integer: true}, presence: true
  validates :status, presence: true

  enum status: {
    "packaged": 0,
    "pending": 1,
    "shipped": 2
  }
end
