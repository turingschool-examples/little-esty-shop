class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price

  enum status: { "disabled" => 0, "enabled" => 1 }

  def self.enabled
    where(status: 1)
  end

  def self.disabled
    where(status: 0)
  end
end
