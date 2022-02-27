class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price

  enum status: { "disabled" => 0, "enabled" => 1 }

  def self.enabled
    where(status: 1)
  end

  def self.disabled
    where(status: 0)
  end

  def self.top_five
    find_by_sql("
      SELECT items.id, items.name, sum(invoice_items.quantity*invoice_items.unit_price) AS revenue
      FROM items JOIN invoice_items ON invoice_items.item_id = items.id
      GROUP BY items.id
      ORDER BY revenue DESC
      LIMIT 5
      ")
  end

  def money_made
    invoice_items.sum('quantity * unit_price')
  end

end
