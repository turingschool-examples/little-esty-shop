class Merchant < ApplicationRecord
  validates :name, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  #enum status: {enable: 0, disable: 1}
end 
