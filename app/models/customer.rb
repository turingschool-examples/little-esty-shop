class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices, source: :invoice_items
  has_many :transactions, through: :invoices

  validates_presence_of :first_name
  validates_presence_of :last_name
end
