class Item < ApplicationRecord
  has_many :invoice_items
  belongs_to :merchant

  def price
    unit_price/100.0
  end

  def change_status
    if status == "able"
      update(status: "unable")
    else
      update(status: "able")
    end
  end

  # def top_revenue_invoice_dates
  #   invoice_items.joins(:invoice)
  #   .where(invoice: {status: "complete"})
  #   .group(:invoice)
  #   .order(Arel.sql('SUM(invoice_items.quantity * invoice_items.unit_price)'))
  #   .last  #might have to do desc and .first to get the newest invoice for equal sums. check
  #   .select("invoices.created_at as invoice_date")
  # end


  # Item.joins(:merchant, invoice_items: [invoice: [:transactions]])
  #   .where(merchants: { id: id })
  #   .where(transactions: { result: 'success' })
  #   .group(:id)
  #   .order(Arel.sql('SUM(invoice_items.quantity * invoice_items.unit_price) DESC'))
  #   .limit(5)
  #   .select(
  #     "items.id as item_id,
  #     items.name as item_name,
  #     SUM(invoice_items.quantity * invoice_items.unit_price / 100) as revenue"
  #   )
end
