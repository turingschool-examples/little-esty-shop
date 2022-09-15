class Merchant < ApplicationRecord
  has_many :items

  def items_not_shipped
    items.joins(:invoices).group(:id).where.not(invoice_items: {status: 2}).pluck(:name)
  end
end