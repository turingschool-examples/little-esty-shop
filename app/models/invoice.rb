class Invoice < ApplicationRecord
  belongs_to :customer
  enum status: ["in progress", "completed", "cancelled"]
  has_many :invoice_items
  has_many :items, through: :invoice_items
end
