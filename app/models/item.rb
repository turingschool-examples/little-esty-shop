class Item < ApplicationRecord
  enum enable: { enable: 0, disable: 1 }

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: { only_integer: true }


  def enable_opposite
    enable == 'enable' ? 'disable' : 'enable' 
  end

  def self.items_ready_to_ship_by_ordered_date(merchant_id)
    select("items.id, items.name, invoice_items.invoice_id AS invoice_id, invoices.status,
      invoices.created_at AS invoiced_date")
      .joins("INNER JOIN invoice_items ON items.id = invoice_items.item_id")
      .joins("INNER JOIN invoices ON invoice_items.invoice_id = invoices.id")
      .where("invoice_items.status <> 2")
      .where("invoices.status <> 0")
      .where("items.merchant_id = ?", merchant_id)
      .order("invoiced_date ASC")
      .distinct
  end
end
