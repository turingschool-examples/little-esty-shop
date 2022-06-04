class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  enum status: %i[disabled enabled]

  def self.enabled_items
    where(status: 1)
  end

  def self.disabled_items
    where(status: 0)
  end

  def find_invoice_id
    invoice_items.first.invoice.id
  end

  def invoice_time
    invoices.order(created_at: :asc)
  end
end
