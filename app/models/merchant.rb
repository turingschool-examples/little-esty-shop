class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers,-> {distinct}, through: :invoices

  validates :name, presence: true

  delegate :favorite_customers, to: :customers
  delegate :items_to_ship, to: :items
end
