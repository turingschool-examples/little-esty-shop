class InvoiceItem < ApplicationRecord
  enum status: [:packaged, :pending, :shipped]    
end