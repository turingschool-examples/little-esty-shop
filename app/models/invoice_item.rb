class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :item
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
end
