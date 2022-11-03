class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.invoices_for(merchant)
    invoice_ids = merchant.invoice_items.pluck("invoice_id")
    Invoice.where(id: invoice_ids)
  end
end