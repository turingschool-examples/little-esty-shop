class Merchant < ApplicationRecord
  has_many :items
  has_many :discounts

  def self.top_merchants
    joins(items: [{invoice_items: { invoice: :transactions} }] )
      .where(transactions: {result: :success})
      .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity / 100.0) AS revenue')
      .group('merchants.id')
      .order('revenue DESC')
      .limit(5)
  end

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

  def top_date(item_id)
    Invoice.joins(:transactions, invoice_items: :item)
      .where(items: { id: item_id })
      .where(transactions: {result: 'success'})
      .group(:created_at)
      .order(
        Arel.sql('SUM(invoice_items.quantity * invoice_items.unit_price) DESC'),
        Arel.sql('invoices.created_at DESC')
      )
      .select(
        "invoices.created_at as date"
      )
      .first
  end

  def find_invoices
    Invoice.joins(invoice_items: [item: [:merchant]])
      .where(merchants: { id: id })
      .distinct
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

  def change_status
    if status == "Enabled"
      update(status: 'Disabled')
    else
      update(status: 'Enabled')
    end
  end

  def top_day
    Invoice.joins(invoice_items: [item: [:merchant]])
      .where(merchants: { id: id })
      .select(
        'invoices.created_at AS day,
        sum(invoice_items.unit_price * invoice_items.quantity / 100.0) AS revenue')
      .group('day')
      .order('revenue')
      .last
  end
end
