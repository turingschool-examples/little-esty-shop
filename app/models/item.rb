class Item < ApplicationRecord
  enum status: { Disabled: 0, Enabled: 1 }

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
end
