class InvoiceItem < ApplicationRecord
  enum status: ["packaged", "pending", "shipped"]

  belongs_to :invoice
  belongs_to :item
  
  def self.items_on_invoice(invoice_id)
    joins(:invoice_items)
    .where('invoice_id = ?', invoice_id)
  end
end
