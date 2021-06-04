class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items

  def top_5
    items.order('unit_price DESC').limit(5)
  end

end
