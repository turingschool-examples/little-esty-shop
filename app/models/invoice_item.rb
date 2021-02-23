class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  validates_presence_of :unit_price, :quantity
  validates :unit_price, :quantity, numericality: { greater_than_or_equal_to: 0 }
  enum status: [:pending, :packaged, :shipped]
end
