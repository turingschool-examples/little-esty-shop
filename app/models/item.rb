class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def top_five_date
    invoice = invoice_items.order(created_at: :desc).first.invoice
    invoice.created_at
  end
end
