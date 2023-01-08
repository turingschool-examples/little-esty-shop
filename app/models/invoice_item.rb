class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_one :merchant, through: :item
  has_one :customer, through: :invoice

  enum status: {packaged: 0,
                pending: 1,
                shipped: 2}
end