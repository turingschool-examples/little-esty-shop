class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  
  enum status: ["pending", "packaged", "shipped"]

  def self.incomplete_item_invoices
    where.not(status: "shipped")
  end
end
