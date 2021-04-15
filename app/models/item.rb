class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name, :description, :unit_price, :merchant_id

  enum status: [:disabled, :enabled]

  def self.ordered_items_no_ship
    joins(:invoice_items).where('status != ?', 2)
  end

  def self.disabled_items
    where(status: "disabled")
  end

  def self.enabled_items
    where(status: "enabled")
  end
end
