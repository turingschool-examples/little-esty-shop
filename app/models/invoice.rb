class Invoice < ApplicationRecord
  belongs_to :customers
  has_one :transactions

  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
end
