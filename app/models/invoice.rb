class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions

  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: { "cancelled" => 0, "completed" => 1, "in progress" => 2 }

  def self.incomplete_invoices
    invoice_ids = self.where.not(status: 1).pluck(:id)
    InvoiceItem.where.not(status: "shipped").where(invoice_id: invoice_ids).order(created_at: :asc)
  end

  def total_revenue
    invoice_items
    .sum('quantity*unit_price')
  end
end
