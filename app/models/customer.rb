class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices
  has_many :items, through: :invoices
  validates_presence_of :first_name, :last_name
end