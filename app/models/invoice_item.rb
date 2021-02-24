class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: { packaged: 0, pending: 1, shipped: 2 }
end
