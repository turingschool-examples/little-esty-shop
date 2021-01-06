class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  validates_presence_of :quantity, :unit_price, :status

  enum status: [:pending, :packaged, :shipped]
end
