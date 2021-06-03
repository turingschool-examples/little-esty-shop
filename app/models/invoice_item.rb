class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :item
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true

  enum status: { packaged: 0, pending: 1, shipped: 2} _prefix: :status
end
