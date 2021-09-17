class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  def enabled_items
    items.enabled
  end

  def disabled_items
    items.disabled
  end
end
