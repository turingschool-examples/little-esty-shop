class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :name

  # def ordered_items_to_ship
  #   item_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:item_id)
  #   item_ids.map do |id|
  #     Item.find(id)
  #   end
  # end

  def ordered_items_to_ship
    Item.find_by_sql "SELECT items.name, invoice_items.invoice_id, invoice_items.status, invoice_items.created_at FROM items INNER JOIN invoice_items ON items.id=invoice_items.item_id WHERE status=0 OR status=1 ORDER BY invoice_items.created_at ASC"
  end

  def group_items_by_status(bool)
    items.where("status = #{bool}")
  end
end
