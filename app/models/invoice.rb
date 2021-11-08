class Invoice < ApplicationRecord
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  belongs_to :customer

  enum status: [:cancelled, :completed, 'in progress']

  def successful_transactions
    transactions.success
  end

  def self.ordered_incomplete_invoices
    incomplete_invoices_ids = InvoiceItem.incomplete_invoices
    Invoice.where(id: incomplete_invoices_ids).order(created_at: :asc).pluck(:id, :created_at)
  end
end
