class Invoice < ApplicationRecord
  enum status:[:'in progress', :cancelled, :completed]
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  validates_presence_of :status
end
