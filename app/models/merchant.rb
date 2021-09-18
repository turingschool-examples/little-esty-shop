class Merchant < ApplicationRecord
  validates :name, presence: true
  has_many :items,   dependent: :destroy
  has_many :invoices,  through: :items
  has_many :customers, through: :invoices

  def favorite_customers
    customers.top_five_with_count
  end

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
