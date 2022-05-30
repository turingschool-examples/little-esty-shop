class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  validates_presence_of :name

  def merchant_ii
    Merchant.find(self.invoice_item)
  end

  def items_ready_to_ship
    merchant_items = Item.where("merchant_id = #{self.id}")
    InvoiceItem.where(item_id: merchant_items).where(status: [0,1])
  end
end

