class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant
  enum status: ["disabled", "enabled"]

  def self.enabled_items
    Item.where(status: 1)
  end

  def self.disabled_items
    Item.where(status: 0)
  end

  def self.invoice_items_details(invoice)
    joins(:invoice_items).where("invoice_items.invoice_id = #{invoice.id}").select("items.*, invoice_items.quantity, invoice_items.unit_price, invoice_items.status AS invoice_item_status")
  end
end