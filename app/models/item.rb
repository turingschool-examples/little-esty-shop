class Item < ApplicationRecord
	has_many :invoice_items
	belongs_to	:merchant 

  
  validates_presence_of :name, :description, :unit_price
  validates :unit_price , numericality: { only_integer: true }
  validates :unit_price , numericality: { greater_than: 0 }


end