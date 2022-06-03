class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name
  validates_presence_of :description
  validates_numericality_of :unit_price

  enum status:["Disabled", "Enabled"]

  def self.enabled
    where(status: 1)
  end

  def self.disabled
    where(status: 0)
  end
end
