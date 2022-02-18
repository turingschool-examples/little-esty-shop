class Invoice < ApplicationRecord
  belongs_to :customer 
  has_many :transactions
  has_many :invoice_items
end 