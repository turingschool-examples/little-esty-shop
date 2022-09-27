class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity, :unit_price
  validates :quantity, numericality: true
  validates :unit_price, numericality: true

  belongs_to :item
  belongs_to :invoice
  has_one :merchant, through: :item
  has_many :bulk_discounts, through: :merchant

  enum status: { pending: 0, packaged: 1, shipped: 2}
end
