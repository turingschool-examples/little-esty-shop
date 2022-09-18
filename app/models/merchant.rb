class Merchant < ApplicationRecord

  has_many :items
  has_many :invoices, through: :items

  def distinct_invoices
    invoices.distinct
  end

  def top_five_revenue
    items
      .joins(invoice_items: [{invoice: :transactions}])
      .select('items.*, invoice_items.item_id, sum(invoice_items.unit_price * invoice_items.quantity) AS item_revenue')
      .group('invoice_items.item_id, items.id')
      .where('transactions.result =?', 1)
      .order(item_revenue: :DESC)
      .limit(5)
  end
end
