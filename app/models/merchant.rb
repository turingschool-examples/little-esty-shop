class Merchant < ApplicationRecord
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
end
