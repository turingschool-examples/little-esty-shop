class Merchant < ApplicationRecord
  has_many(:items)

  def favorite_customers
  end

  def items_ready_to_ship
    item_id = InvoiceItem.where.not(status: 'shipped').pluck(:item_id)
    items.where(id: item_id)
  end
end
