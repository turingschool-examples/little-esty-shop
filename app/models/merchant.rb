class Merchant < ApplicationRecord
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :items

  def enabled_items
    Item.all_enabled_items.where(merchant_id: self.id)
  end

  def disabled_items
    Item.all_disabled_items.where(merchant_id: self.id)
  end

  def top_five_items
    Item.where(merchant_id: self.id).top_five_by_revenue
  end
end
