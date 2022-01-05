class Merchant < ApplicationRecord
  has_many :items
  validates :name, presence: true

  # def top_five_customers
  #   customers = Item.where(merchant_id: self.id)
  #   Transaction.find(merchant_id: :id).limit(5)
  # end

  def items_ready_to_ship
    Item.joins(:invoice_items).where(invoice_items: {status: 1})
  end
end
