class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant
  scope :enabled, -> {where(enabled: true)}
  scope :disabled, -> {where(enabled: false)}

  def self.items_to_ship
    joins(:invoices).select("items.*, invoice_id, invoices.created_at AS invoice_created").where(invoice_items: {status: 1}).order("invoice_created")
  end
end
