class Merchant < ApplicationRecord
  has_many :items

  def items_not_shipped_sorted_by_date
    items.joins(:invoices).order("invoices.created_at").where.not(invoice_items: {status: 2})
  end
end