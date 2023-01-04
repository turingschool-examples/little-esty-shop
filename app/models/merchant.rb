class Merchant < ApplicationRecord 
  has_many :items
  has_many :invoices, :through => :items, dependent: :destroy
end