class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: [:cancelled, 'in progress', :completed]

  def self.admin_incomplete_invoices #still needs to be tested in the Invoice model test
    Invoice.select('invoices.*, invoice_items.invoice_id as number')
    .joins(:invoice_items)
    .where('invoice_items.status != 2')
    .order(:created_at)
    .uniq
  end

  def self.merchant_invoices(id)
    joins(:items)
    .select('invoices.*')
    .where('merchant_id = ?', id).distinct
  end
end
