class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items, dependent: :destroy
  has_many :invoices, through: :invoice_items, dependent: :destroy
  has_many :customers, through: :invoices, dependent: :destroy
  has_many :transactions, through: :invoices, dependent: :destroy

  def unshipped_items 
    items.select('items.id, items.name, invoice_items.invoice_id as invoice_id')
         .joins(invoice_items: :invoice)
         .where(invoices: {status: 0})
         .where.not(invoice_items: {status: 2})    
  end

end

