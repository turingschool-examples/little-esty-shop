class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  def self.incomplete_invoices
    # all.where.not(status: "shipped").distinct(:invoice_id).pluck(:invoice_id)
    all.where.not(status: "shipped").order(:created_at).distinct(:invoice_id)
  end
end
