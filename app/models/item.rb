class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price
  validates :unit_price, numericality: true
  enum status: ["disabled", "enabled"]

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
end
