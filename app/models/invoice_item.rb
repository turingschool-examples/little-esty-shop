class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  
  enum status: ["pending", "packaged", "shipped"]

  def self.incomplete_item_invoices
    joins(:invoice).where.not(status: "shipped").order("invoices.created_at")
  end
end
