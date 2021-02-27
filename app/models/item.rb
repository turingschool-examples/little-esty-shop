class Item < ApplicationRecord
  validates_presence_of :name, :description
  validates :unit_price, numericality: true
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def change_status(status)
    self.item_status = status
    self.save
  end

  def self.enabled_items
    where(item_status: true)
  end

  def self.disabled_items
    where(item_status: false)
  end
end
