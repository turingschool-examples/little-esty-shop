class Invoice < ApplicationRecord
  has_many :invoice_items
end
