class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  
  enum status: ["in progress", "cancelled", "completed"]

  def self.find_invoiceitem_quantity(invoice, item)
    joins(:invoice_items).group(:id).where(id: invoice.id).first.invoice_items.where(item_id: item.id).first.quantity
  end

  def self.find_invoiceitem_unitprice(invoice, item)
    joins(:invoice_items).group(:id).where(id: invoice.id).first.invoice_items.where(item_id: item.id).first.unit_price
  end

  def self.find_invoiceitem_status(invoice, item)
    joins(:invoice_items).group(:id).where(id: invoice.id).first.invoice_items.where(item_id: item.id).first.status
  end
end
