class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  def enabled_items
    items.enabled
  end

  def disabled_items
    items.disabled
  end

  def update_status(new_status)
    update(status: new_status)
  end
end
