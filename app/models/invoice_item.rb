class InvoiceItem < ApplicationRecord
  enum status: ["packaged", "pending", "shipped"]

  belongs_to :invoice
  belongs_to :item

  def invoice_creation_date
    invoice.creation_date_formatted
  end
end
