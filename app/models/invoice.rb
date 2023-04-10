class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items , through: :invoice_items
  has_many :transactions
  belongs_to :customer
end