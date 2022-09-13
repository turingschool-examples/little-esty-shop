class Invoice < ApplicationRecord
  validates_presence_of :status

  belongs_to :customer
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
end