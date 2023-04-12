class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant
  enum status: ["disabled", "enabled"]

  def self.enabled_items
    Item.where(status: 1)
  end

  def self.disabled_items
    Item.where(status: 0)
  end
end