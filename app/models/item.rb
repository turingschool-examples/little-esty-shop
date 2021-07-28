class Item < ApplicationRecord
  # validates :
  belongs_to :merchant
  has_many :invoice_items
  # has_many :, through: :
end