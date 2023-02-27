class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  def item_invoice_id
    invoice_items.first.invoice_id
  end

  def self.enabled
    where(status: "enabled")
  end

  def self.disabled
    where(status: "disabled")
  end
end
