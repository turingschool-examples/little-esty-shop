class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  validates_presence_of :status

end
