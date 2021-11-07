class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  enum status: [:packaged, :pending, :shipped]

  def item_revenue
    quantity * unit_price
  end

  def self.item_revenue
    revenue = group(:item_id).sum('quantity * unit_price')
    revenue.sort_by{ |_, v| -v }.to_h.keys
  end

  def self.incomplete_invoices

    incomplete_invoices = InvoiceItem.select('invoice_items.*').where("status = 0 OR status = 1").distinct.order(invoice_id: :asc).pluck(:invoice_id)
    if incomplete_invoices == nil
      incomplete_invoices = []
    end
    incomplete_invoices
  end
end
