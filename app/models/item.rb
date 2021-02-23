class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  validates_presence_of :name, :unit_price
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }

  enum status: [:enabled, :disabled]
end
