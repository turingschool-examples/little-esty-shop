class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity, :unit_price, :status
  enum status: { pending: 0, packaged: 1, shipped: 2}

  belongs_to :item
  belongs_to :invoice
  has_many :merchants, through: :item
  has_many :transactions, through: :invoice
  has_many :customers, through: :invoice
end