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
      .group(:id)
      .order(Arel.sql('SUM(invoice_items.quantity * invoice_items.unit_price) DESC'))
      .limit(5)
      .select(
        "items.id as item_id,
        items.name as item_name,
        SUM(invoice_items.quantity * invoice_items.unit_price / 100) as revenue"
      )
  end
end
