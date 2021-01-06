class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions, dependent: :destroy
  
  enum status: [ :cancelled, :in_progress, :completed ]
end
