class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :invoice_items, through: :items
   
  def merchant_invoices
    invoices.distinct.order(:id)
  end

  def items_not_yet_shipped
    invoices.order(created_at: :asc)
    invoice_items.where.not(status: "shipped")
  end
end
