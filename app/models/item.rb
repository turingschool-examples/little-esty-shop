class Item < ApplicationRecord

	has_many :invoice_items
	belongs_to	:merchant
	has_many :invoices, through: :invoice_items

  	validates_presence_of :name, :description, :unit_price, :status
  	validates :unit_price , numericality: { only_integer: true }
  	validates :unit_price , numericality: { greater_than: 0 }

	enum status: {"enabled" => 0, "disabled" => 1}


end
