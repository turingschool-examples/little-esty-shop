class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions


  def format_time
    # require "pry";binding.pry
    created_at.strftime("%A, %B %d, %Y")
    # InvoiceItem.where.not(status: "shipped")
    # joins(:invoice_item).all.where.not(status: "shipped").pluck(:created_at).strftime("%A, %B %d, %Y")
    # Invoice.where(invoice_item: :)
    # Invoice.pluck(:created_at)
    # Invoice.all.where(invoice.id = invoice_items.invoice_id).pluck(:created_at)
  end
end
