class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items

  validates_presence_of :name
end
