class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  
  enum status: ["packaged", "pending", "shipped"]

  def self.invoice_items_not_shipped
    where.not(status: 2).distinct.pluck(:invoice_id)
  end
end
