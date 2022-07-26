class InvoiceItem < ApplicationRecord
  enum status: { pending: 0, shipped: 1, packaged: 2}
  # default: :pending
end
