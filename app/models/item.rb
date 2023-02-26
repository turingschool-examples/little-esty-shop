class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  
  enum status: { disabled: 0, enabled: 1 }

  def item_invoice_id
    invoice_items.first.invoice_id
  end
end
