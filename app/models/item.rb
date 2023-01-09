class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  validates_presence_of :name, :description, :unit_price
  validates_numericality_of :unit_price

  def unit_price_to_dollars
    unit_price.to_f / 100
  end

  def self.dollars_to_unit_price(dollars)
    (dollars.to_f * 100).to_i
  end
end