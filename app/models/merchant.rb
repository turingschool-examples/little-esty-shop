class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items

  validates :name, presence: true
end
