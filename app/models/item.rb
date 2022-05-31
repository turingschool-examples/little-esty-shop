class Item < ApplicationRecord 
  belongs_to :merchant

  has_many :invoice_items
  has_many :items, through: :invoice_items
  validates_presence_of :name 
  validates_presence_of :description 
  validates_presence_of :unit_price 

  def unit_price_to_dollars
    unit_price.to_s.rjust(3, "0").insert(-3, ".")
  end
end