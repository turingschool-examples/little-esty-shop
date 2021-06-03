class InvoiceItem < ApplicationRecord
  enum status: [:packaged, :pending, :shipped]
  belongs_to :invoice
  belongs_to :item 
end
