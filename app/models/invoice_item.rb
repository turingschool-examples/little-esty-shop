# app/models/invoice_items

class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  def self.invoices_with_unshipped_items
    distinct.where.not(status: 'shipped').order(:invoice_id).pluck(:invoice_id)
  end
end
