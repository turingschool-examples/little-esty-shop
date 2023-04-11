class Invoice < ApplicationRecord
  belongs_to :customers
  has_many :invoice_items
  has_many :items, through: :invoice_items
end
