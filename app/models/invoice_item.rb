class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  enum status: [:pending, :packaged, :shipped]

  def self.items_by_invoice(invoice_id)
    joins(:invoice, :item).select('items.name', 'invoice_items.quantity', 'invoice_items.unit_price', 'invoice_items.status', 'invoices.id', '(invoice_items.quantity * invoice_items.unit_price) as revenue').where("invoices.id = #{invoice_id}")
  end

end
