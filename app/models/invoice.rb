class Invoice < ApplicationRecord
  validates_presence_of :status
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [ "in progress", "cancelled", "completed" ]

  def self.incomplete_invoices
    joins(:invoice_items)
    .where('invoice_items.status != ?', 2)
    .select('invoices.*, invoice_items.invoice_id AS invoice_id, invoices.created_at AS invoice_created_at')
    .order('invoice_created_at')
  end
end
