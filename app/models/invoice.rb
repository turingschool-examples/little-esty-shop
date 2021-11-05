class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items, source: :invoice_items

  
  enum status: [:cancelled, :completed, 'in progress' ]
  
end
