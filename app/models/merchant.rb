class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
	has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def unshipped_items
    invoice_items.where(status: 'pending').or(invoice_items.where(status: 'packaged'))
  end
end
