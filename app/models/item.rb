class Item < ApplicationRecord
  included OrderableByTimestamp
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices,   through: :invoice_items
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_numericality_of :unit_price
end
