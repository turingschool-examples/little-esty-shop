class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_numericality_of :unit_price

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  enum status: [ :disabled, :enabled ]

  def self.ready_to_ship
    where(invoice_items: {status: "packaged"})
  end

  def self.disabled_items 
    where(status: 0)
  end

  def self.enabled_items
    where(status: 1)
  end
end
