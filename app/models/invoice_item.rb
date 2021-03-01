class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  enum status: [:pending, :packaged, :shipped]

  def self.items_by_invoice(invoice_id)
    joins(:invoice, :item).select('items.name', 'invoice_items.quantity', 'invoice_items.unit_price', 'invoice_items.status', 'invoices.id').where("invoices.id = #{invoice_id}")
  end

  def merchants_best_day
    require "pry"; binding.pry
  end

end
