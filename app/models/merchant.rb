class Merchant < ApplicationRecord
  has_many :items

  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def invoice_items_to_ship
    self.invoice_items.joins(:invoice).where(status: 0).order("invoices.created_at")
  end

  def enabled_items
    items.where(status: "enabled")
  end

  def disabled_items
    items.where(status: "disabled")
  end
end