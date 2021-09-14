class Merchant < ApplicationRecord
  self.primary_key = :id

  has_many :items, dependent: :destroy

  has_many :merchant_invoices
  has_many :invoices, through: :merchant_invoices
end
