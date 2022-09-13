class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity, :unit_price, :status

  belongs_to :item
  belongs_to :invoice
  has_many :merchants, through: :item
  has_many :transactions, through: :invoice
  has_many :customers, through: :invoice
end