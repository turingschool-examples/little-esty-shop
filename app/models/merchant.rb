class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :name

  def ready_to_ship
    items.select("items.*, invoice_items.status as not_shipped").joins(:invoice_items).where.not("invoice_items.status = ?", 2)
  end
end
