class InvoiceItem < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  belongs_to :item
  belongs_to :invoice

  def self.incomplete_invoices
    all.where.not(status: "shipped").order(:created_at).distinct(:invoice_id)
  end

  def item_name
    Item.find(item_id).name
  end

  def total_revenue(id)
    number_to_currency(
    InvoiceItem
    .where("invoice_id = ?", id)
    .sum("quantity * unit_price"))
  end
end
