class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :items, through: :invoices
end