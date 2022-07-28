class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  # def self.ready_to_ship(merchant_id)
  #   Item.joins(:invoices)
  #   .select("items.name, invoice_items.id, invoices.id, invoices.created_at")
  #   .where(invoice_items: {status: :packaged }, items: {merchant_id: merchant_id})
  #   .order("invoices.created_at")
  # end
end
