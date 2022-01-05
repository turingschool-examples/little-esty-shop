class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  validates :item, :invoice, :quantity, :unit_price, presence: true
  validates :quantity, :unit_price, numericality: { only_integer: true }

    enum status: {
    pending: 0,
    packaged: 1,
    shipped: 2
  }
end
