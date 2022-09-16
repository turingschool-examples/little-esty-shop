class Merchant < ApplicationRecord
  validates_presence_of :name
  enum status: { Enabled: 0, Disabled: 1}

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
end
