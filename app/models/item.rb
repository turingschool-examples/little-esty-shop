class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: { only_integer: true }


  def self.items_ready_to_ship(merchant_id)
    select("items.id, items.name, invoice_items.invoice_id AS invoice_id")
      .joins(:invoice_items)
      .where("invoice_items.status <> 2")
      .where("items.merchant_id = ?", merchant_id)
      .distinct
      .order(:id)
  end

end
