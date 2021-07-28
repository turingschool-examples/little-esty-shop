class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  def self.incomplete_invoices
    joins(:invoice_items)
    .where.not('invoice_items.status = 2')
    .select('invoices.id, invoices.created_at')
    .order(:created_at)
    .distinct
  end
end
