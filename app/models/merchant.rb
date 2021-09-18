class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  validates :name, presence: true

  def enabled_items
    items.enabled
  end

  def disabled_items
    items.disabled
  end

  def update_status(new_status)
    update(status: new_status)
  end

  def disabled?
    status == 'Disabled'
  end

  def self.enabled_merchants
    where status: 'Enabled'
  end

  def self.disabled_merchants
    where status: 'Disabled'
  end
end
