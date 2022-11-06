class Item < ApplicationRecord
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  enum status: [ :disabled, :enabled ]

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
end
