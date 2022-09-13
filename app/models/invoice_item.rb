class InvoiceItem < ApplicationRecord
  enum: [ :pending, :packaged, :shipped 
  ]
end