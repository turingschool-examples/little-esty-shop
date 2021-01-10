class Merchant < ApplicationRecord
  validates_presence_of :name
  validates_numericality_of :status

  has_many :invoices
  has_many :items

  enum status: [:enabled, :disabled]
end
