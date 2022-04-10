class Merchant < ApplicationRecord
  has_many :items
  validates_presence_of(:name)


  def items_ready_to_ship
    InvoiceItem.where(item: items).where.not(status: 2)
  end
end
