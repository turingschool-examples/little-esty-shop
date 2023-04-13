class Merchant < ApplicationRecord
  has_many :items

  validates_presence_of :name

  def enabled_items
    items.where(status: 0)
  end

  def disabled_items
    items.where(status: 1)
  end
end
