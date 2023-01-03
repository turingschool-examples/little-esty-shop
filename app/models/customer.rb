class Customer < ApplicationRecord

  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices, dependent: :destroy
  has_many :items, through: :invoice_items, dependent: :destroy
  has_many :merchants, through: :items, dependent: :destroy
end