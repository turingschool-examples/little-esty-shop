class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_many :customer, through: :invoice

  enum status: ["pending", "packaged", "shipped"]

  def self.incomplete_invoices
    select("invoice_items.*")
    .where.not(status: 2)
    .order(:invoice_id).distinct
    .pluck(:invoice_id)
  end
end
