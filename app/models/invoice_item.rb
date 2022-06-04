class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  enum status: %w[pending packaged shipped]
end
