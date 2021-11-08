class Merchant < ApplicationRecord
  has_many :items

  def favorite_customers
    Customer.joins(invoices: [:transactions, [invoice_items: [item: [:merchant]]]])
      .where(transactions: { result: 'success' })
      .where(merchants: { id: id })
      .group(:id)
      .order(Arel.sql('COUNT(transactions.id) DESC'))
      .limit(5)
      .select(
        "customers.first_name as first_name,
        customers.last_name as last_name,
        COUNT(transactions.id) as successful_transactions"
      )
  end

  def items_ready_to_ship
    Item.joins(:merchant, invoice_items: [:invoice])
      .where.not(invoice_items: {status: "shipped"})
      .where(merchants: { id: id })
      .select(
        "items.name as item_name,
        invoices.id as invoice_id,
        invoices.created_at as invoice_created_at"
      )
      .order("invoice_created_at")
  end

  def top_items_by_revenue
    Item.joins(:merchant, invoice_items: [invoice: [:transactions]])
      .where(merchants: { id: id })
      .where(transactions: { result: 'success' })
      .group(:id, "invoices.created_at")
      .order(Arel.sql('SUM(invoice_items.quantity * invoice_items.unit_price) DESC'))
      .limit(5)
      .select(
        "items.id as item_id,
        items.name as item_name,
        SUM(invoice_items.quantity * invoice_items.unit_price / 100) as revenue,
        invoices.created_at as invoice_date"
      )
  end

  # def top_revenue_invoice_dates(item_id)
  #   Item.joins(invoice_items: [invoice: [:transactions]])
  #       .where(items: { id: item_id })
        # .where(transactions: {result: :'success'})
        # .group("invoices.created_at")
        # .order(Arel.sql('SUM(invoice_items.quantity * invoice_items.unit_price)'))
        # .last
        # .select("invoices.created_at as invoice_date")
  # end
# 
#   def top_revenue_invoice_dates(item_id)
# require "pry"; binding.pry
#     Invoice.joins(:transactions, invoice_items: [:item])
#           .where(items: { id: item_id })
#           .where(transactions: {result: :'success'})
#           .group("invoices.created_at")
#           .order(Arel.sql('SUM(invoice_items.quantity * invoice_items.unit_price)'))
#           .last
#           .select("invoices.created_at as invoice_date")
#   end

#might have to do desc and .first to get the newest invoice for equal sums. check

  # def top_revenue_invoice_dates
  #   top_items_id = top_items_by_revenue.item_id
  #
  #   Invoice.joins(:transactions, invoice_items: [:item])
  #     .where(transactions: { result: 'success'})
  #     .where("items.id = top_items_id")
  #     .group(:items)
  #     .order(Arel.sql('(invoice_items.quantity * invoice_items.unit_price) DESC'))
  #     .select("invoices.created_at as invoice_date")
  #
  #   Item.where(id: top_items_id)
  #     .joins(item: [invoice: [:transactions]])
  #     .where(transactions: { result: 'success' })
  #     .group(:invoices)
  #     .order(Arel.sql('(invoice_items.quantity * invoice_items.unit_price) DESC'))
  #     .select(
  #       "invoice_items.id as item_id,
  #       items.name as item_name,
  #       SUM(invoice_items.quantity * invoice_items.unit_price / 100) as revenue"
  #     )
  # end
end
