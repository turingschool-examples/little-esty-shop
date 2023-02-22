class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices
  belongs_to :merchant
end