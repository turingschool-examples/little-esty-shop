class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  enum status: {enable: 0, disable: 1}

  def self.enabled_merchants
    Merchant.where(status: 'enable')
  end

  def self.disabled_merchants
    Merchant.where(status: 'disable')
  end

  def disabled_items
    items.where(status: "Disabled")
  end

  def enabled_items
    items.where(status: "Enabled")
  end

  def ready_to_ship
    invoice_items.joins(:invoice).where(status: [0, 1]).order('invoices.created_at')
  end

  def top_five_customers
    customers.joins(invoices: :transactions)
              .where(transactions: { result: 0 })
              .select('customers.*, count(transactions.*) as total_transactions')
              .order(total_transactions: :desc)
              .group('customers.id')
              .limit(5)
  end

  def self.top_five_merchants
    joins(invoices: :transactions).where(transactions: { result: 0 })
    .joins(:invoice_items)
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as rev_count')
    .group(:id)
    .order(rev_count: :desc)
    .limit(5)
  end

  def best_sales_date
    invoices.joins(:transactions, :invoice_items).where(transactions: {result: 0})
    .select('invoices.*, sum(invoice_items.quantity) as total_sales')
    .group(:id)
    .order(created_at: :desc)
    .first.created_at
  end


  def ordered_items_to_ship
    item_ids = InvoiceItem.where("status = 0 OR status = 1").order(:created_at).pluck(:item_id)
    item_ids.map do |id|
      Item.find(id)
    end
  end

  def top_five_items
    items.joins(invoice_items: { invoice: :transactions}).where(transactions: {result: 0})
    .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_sales')
    .group(:id)
    .order(total_sales: :desc)
    .limit(5)
  end
end
