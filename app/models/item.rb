class Item < ApplicationRecord
  enum status: {enabled: 0, disabled: 1}
  
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items, dependent: :destroy
  has_many :customers, through: :invoices, dependent: :destroy
  has_many :transactions, through: :invoices, dependent: :destroy

  validates_presence_of :name, :description, :unit_price
end