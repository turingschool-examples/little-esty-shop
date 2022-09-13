class InvoiceItem < ApplicationRecord
  enum status: [ :pending, :packaged, :shipped ]
end