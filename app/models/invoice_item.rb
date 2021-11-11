class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  enum status: [:packaged, :pending, :shipped]

  def self.incomplete_invoices
  incomplete_invoices =  InvoiceItem.where.not(status: 2)
                                    .distinct
                                    .pluck(:invoice_id)
  Invoice.order(:created_at).find(incomplete_invoices)
  end
end
