class Item < ApplicationRecord
  belongs_to :merchant

  enum status: [:disabled, :enabled]

  def self.enabled_items
    where(status: 1)
  end

  def self.disabled_items
    where(status: 0)
  end

end
