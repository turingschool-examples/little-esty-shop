class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def items_ready_to_ship
    invoice_items.joins(:invoice).where.not(status: 2).order('invoices.created_at')
  end
end

