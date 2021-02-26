class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  def matching_invoice_item(invoice_id)
    invoice_items
    .where(invoice_id: invoice_id)
    .first
  end
end
