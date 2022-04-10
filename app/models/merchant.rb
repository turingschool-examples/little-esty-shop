class Merchant < ApplicationRecord
  has_many :items
  validates_presence_of(:name)


  def items_ready_to_ship
    InvoiceItem.where(item: items).where.not(status: 2)
  end

  def enabled_items
    items.where(status: 0)
  end

  def disabled_items
    items.where(status: 1)
  end
end
