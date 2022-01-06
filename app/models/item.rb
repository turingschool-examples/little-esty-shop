class Item < ApplicationRecord
  belongs_to(:merchant)
  has_many(:invoice_items)
  has_many(:invoices, through: :invoice_items)

  enum status: {"disabled" => 0, "enabled" => 1}

  def self.only_enabled
    where(status: 1)
  end

  def self.only_disabled
    where(status: 0)
  end

  def revenue_generated
    InvoiceItem.where(item_id: self.id).sum('quantity*unit_price')
  end

  def self.top_5
    find_by_sql("
      SELECT items.id, items.name, sum(invoice_items.quantity*invoice_items.unit_price) AS revenue
      FROM items JOIN invoice_items ON invoice_items.item_id = items.id
      GROUP BY items.id
      ORDER BY revenue DESC
      LIMIT 5
    ")
  end

end
