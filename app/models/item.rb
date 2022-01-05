class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  validates :name, :description, :merchant, presence: true
  validates :unit_price, numericality: { only_integer: true }
end
