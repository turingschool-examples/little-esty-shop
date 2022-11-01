class Merchant < ApplicationRecord
  has_many :items

  def enabled_items 
    items.where(status: "enabled")
  end

  def disabled_items 
    items.where(status: "disabled")
  end
end