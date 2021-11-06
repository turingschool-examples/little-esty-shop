class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  def self.total_revenue(invoice)
    where(invoice_id: invoice.id).sum(:unit_price)
  end
end
