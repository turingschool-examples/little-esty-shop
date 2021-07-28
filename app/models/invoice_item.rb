class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: {pending: 0, packeged: 1, shipped: 2}
end
