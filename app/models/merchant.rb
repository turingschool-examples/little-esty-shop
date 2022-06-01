class Merchant < ApplicationRecord
  has_many :items

  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices 

  validates_presence_of :name
  validates_presence_of :created_at
  validates_presence_of :updated_at
end
