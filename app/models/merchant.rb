class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices

  # def favorite_customers
  #
  # end

  def items_to_ship
    item_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:item_id)
    Item.find(item_ids)
  end
end
