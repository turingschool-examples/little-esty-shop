# app/models/invoice_items

class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  def self.find_invoice_id(item_id)
    joins(:invoice).where("#{item_id} = invoice_items.item_id").pluck(:invoice_id).first
  end

  def self.find_invoice_created_at(item_id)
    joins(:invoice).select("invoices.created_at").where("#{item_id} = invoice_items.item_id").pluck(:created_at).first
  end
end
