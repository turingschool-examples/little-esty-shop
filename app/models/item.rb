class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: { only_integer: true }


  def self.items_ready_to_ship_by_ordered_date(merchant_id)
    select("items.id, items.name, invoice_items.invoice_id AS invoice_id, invoices.status,
      invoice_items.created_at AS ordered_date")
      .joins(:invoice_items)
      .joins(:invoices)
      .where("invoice_items.status <> 2")
      .where("invoices.status = 1")
      .where("items.merchant_id = ?", merchant_id)
      .order("ordered_date ASC")
      .distinct
  end

end
