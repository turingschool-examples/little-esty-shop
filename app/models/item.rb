class Item < ApplicationRecord
  has_many :invoices, through: :invoice_items 
end
