class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant
end
