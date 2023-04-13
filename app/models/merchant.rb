class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items

  validates_presence_of :name
end

