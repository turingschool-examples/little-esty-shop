class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  
  enum status: [ :cancelled, :in_progress, :completed ]

  def self.incomplete_invoices
    # Invoice.where.not(status: :completed).count (3293)
    # joins(:invoice_items).where.not('invoice_items.status = ?', 2).where.not(status: :completed).distinct.pluck(:id)
    # Invoice.joins(:invoice_items).select("invoices.status, invoice_items.status as poop").where.not('invoice_items.status = 2 AND invoices.status = 2').distinct.pluck(:id)

    joins(:invoice_items)
    .where.not(status: Invoice.statuses[:completed])
    .where.not("invoice_items.status = ?", InvoiceItem.statuses[:shipped])
    .distinct
    .pluck(:id)

    # Invoice.joins(:invoice_items).select('invoice.*, invoice_items.status as xxx').where("invoice_items.status != ?", InvoiceItem.statuses[:shipped]).distinct.pluck(:id)
  end
end

# Where not shipped and not complete

InvoiceItem.find_by(invoice_id: 1489)
Invoice.find(1489)