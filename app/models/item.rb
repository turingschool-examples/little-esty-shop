class Item < ApplicationRecord
  enum status: ["Enabled", "Disabled"]

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.enabled
    where(status: "Enabled")
  end

  def self.disabled
    where(status: "Disabled")
  end

  def item_best_day
    binding.pry
  end
end
