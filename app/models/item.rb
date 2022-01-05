class Item < ApplicationRecord
  belongs_to :merchant
  def self.invoice_finder(merchant_id)
    invoice_items = []
    invoices = []
    items = Item.where(merchant_id: merchant_id)
    items.each do |item|
      invoice_items.push(InvoiceItem.where(item_id: item.id))
    end
    invoice_items.flatten.each do |invoice_item|
      invoices.push(Invoice.where(id: invoice_item.invoice_id))
    end
    invoices.flatten
  end
end
