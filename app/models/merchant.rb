class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  enum status: [:Disabled, :Enabled]

  validates :name, presence: true

  def invoice_finder
    Invoice.joins(:invoice_items => :item).where(:items => {:merchant_id => self.id})
  end

  def top_customers(customer_count = 5)
    if customer_count > customers.count
      customer_count = customers.count
    end

    Customer.joins(:invoices => :transactions)
                .where(:transactions => {result: 0})
                .select("customers.*, count(transactions.id) as count_transactions_id")
                .group(:id)
                .order(count_transactions_id: :desc)
                .limit(customer_count)
  end

  def self.top_customers(customer_count = 5)
    customers = Customer.all
    if customer_count > customers.count
      customer_count = customers.count
    end

    Customer.joins(:invoices => :transactions)
            .select("customers.*, count(transactions.id) as count_transactions_id")
            .where(:transactions => {result: 0})
            .group(:id)
            .order(count_transactions_id: :desc)
            .limit(customer_count)
  end

  def self.enabled_merchants
    Merchant.all.where(status: 1)
  end

  def self.disabled_merchants
    Merchant.all.where(status: 0)
  end

  def items_ready_to_ship
    items.joins(:invoice_items => :invoice)
          .where.not(:invoice_items => {status: 2})
          .order("invoices.created_at asc")
          # this needs to be distinct. If there are two identical items with duplicate invoices and invoice items it repeats.
  end

  def popular_items(item_count = 5)

    if item_count > items.count
      item_count = items.count
    end

    items.joins(invoice_items: {invoice: :transactions}).where(transactions: {result: 0})
    .select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) as potential_revenue")
    .order(potential_revenue: :desc)
    .group(:id)
    .limit(item_count)
  end

  def self.top_merchants(merchant_count = 5)

    if merchant_count > Merchant.all.count
      merchant_count = Merchant.all.count
    end

    Merchant.joins(:transactions)
            .where(transactions: {result: 0})
            .group(:id)
            .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
            .order(revenue: :desc)
            .limit(merchant_count)
  end

  def best_day
    invoices.joins(:transactions)
    .where(transactions: {result: 0})
    .group(:id)
    .select("invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .order(revenue: :desc)
    .first.created_at
  end
end
