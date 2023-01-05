class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  validates_presence_of :name, :description
  validates_numericality_of :unit_price

  def unit_price_to_dollars
    unit_price.to_f / 100
  end
end