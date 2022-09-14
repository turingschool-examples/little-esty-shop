class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :merchant_id

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items


  def self.find_items_to_ship(merchant_id)
    Item.select(:id, :name, "invoices.created_at as invoice_create_date", "invoice_items.invoice_id as invoice_id")
      .joins(:invoices, :invoice_items)
      .distinct
      .where.not("invoice_items.status = ?", 2)
      .where(merchant_id: merchant_id)
      .order("invoice_create_date")
  end
  
  def current_price
    unit_price.to_f / 100
  end
end