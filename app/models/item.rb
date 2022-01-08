class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  validates :name, :description, :merchant, presence: true
  validates :unit_price, numericality: { only_integer: true }

  # enum result: {
  #   disabled: 0,
  #   enabled: 1
  # }

  enum status: [:disabled, :enabled]
end
