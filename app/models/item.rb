class Item < ApplicationRecord
  has_many :invoice_items, dependent: :destroy
end