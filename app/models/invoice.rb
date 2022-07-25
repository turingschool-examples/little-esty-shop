class Invoice < ApplicationRecord
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
end