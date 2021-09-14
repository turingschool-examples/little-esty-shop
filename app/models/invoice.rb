class Invoice < ApplicationRecord
  self.primary_key = :id

  belongs_to :customer
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :transactions, dependent: :destroy

  has_many :merchant_invoices
  has_many :merchants, through: :merchant_invoices

  enum status: ['in progress', 'completed', 'cancelled']
end
