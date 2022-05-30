class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items  
  has_many :invoices, through: :invoice_items

  validates_presence_of :name
end
