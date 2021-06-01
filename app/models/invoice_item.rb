class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: {pending: 0, packaged: 1, shipped: 2}
  # enum status: [:pending, :packaged, :shipped]

end
