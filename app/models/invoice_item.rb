class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  enum status: [:packaged, :pending, :shipped]

  def self.incomplete_invoices
  incomplete_invoices =  InvoiceItem.where.not(status: "2")
                                    .distinct
                                    .pluck(:invoice_id)
    incomplete_invoices.map do |invoice|
      Invoice.find(invoice)
    end
  end
end
