class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :merchants
  has_many :items, through: :merchants
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates_presence_of :discount, :quantity
end
