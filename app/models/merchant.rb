class Merchant < ApplicationRecord
  has_many :items
  
  # public
  def enabled_items
    items.where(enabled: true)
  end

  def disabled_items
    items.where(enabled: false)
  end
end
