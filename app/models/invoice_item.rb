class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  def self.incomplete_invoices
    # require "pry"; binding.pry
    all.where.not(status: "shipped").distinct(:invoice_id).pluck(:invoice_id)
    # InvoiceItem.select(:invoice_id).where("status: 'pending' OR status: 'packaged'")
    # InvoiceItem.select(:status).where("status: 'pending' OR status: 'packaged'").distinct(:invoice_id)
    # InvoiceItem.where("status: 'pending' OR status: 'packaged'").pluck(:invoice_id)
  end
end
