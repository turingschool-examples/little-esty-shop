class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def quantity_ordered(invoice) 
    InvoiceItem.find_by(item_id: self.id, invoice_id: invoice.id).quantity
  end

  def price_sold(invoice)
    InvoiceItem.find_by(item_id: self.id, invoice_id: invoice.id).unit_price
  end

  def item_status(invoice)
    InvoiceItem.find_by(item_id: self.id, invoice_id: invoice.id).status
  end

  def top_day
    invoices.select('invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) as revenue').group('invoices.created_at').order('revenue desc').limit(1)
  end
end


