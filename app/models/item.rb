class Item < ApplicationRecord 
  enum status: ["enabled", "disabled"]

  belongs_to :merchant 
  has_many :invoice_items 
  has_many :invoices, through: :invoice_items 

  def self.enabled_items
    where(status: 0)
  end

  def self.disabled_items
    where(status: 1)
  end
end 