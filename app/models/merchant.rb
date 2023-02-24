class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :invoice_items, through: :items

  def merchant_invoices
    invoices.distinct.order(:id)
  end

  def items_not_yet_shipped
    invoice_items.where(status: ["pending", "packaged"]).pluck(:name)
  end
end
