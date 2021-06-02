class Item < ApplicationRecord
  has_many :invoice_items, dependent: :destroy
  belongs_to :merchant
end