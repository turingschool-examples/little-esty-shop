class Invoice < ApplicationRecord
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_one :merchant, through: :items

  enum status: [ :"in progress", :cancelled, :completed ]
end
