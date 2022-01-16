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

    Customer.merge(Customer.successful_transactions_count)
            .limit(customer_count)
  end

  def self.top_customers(customer_count = 5)
    customers = Customer.all
    if customer_count > customers.count
      customer_count = customers.count
    end

    Customer.merge(Customer.successful_transactions_count)
            .limit(customer_count)
  end

  def self.enabled_merchants
    Merchant.all.where(status: 1)
  end

  def self.disabled_merchants
    Merchant.all.where(status: 0)
  end

  def invoice_items_ready_to_ship
    invoice_items.joins(:invoice)
          .where.not(status: 2)
          .order("invoices.created_at asc")
          # this needs to be distinct. If there are two identical items with duplicate invoices and invoice items it repeats.
  end

  def popular_items(item_count = 5)

    if item_count > items.count
      item_count = items.count
    end

    items.joins(:transactions)
    .select("items.*")
    .merge(Transaction.successful)
    .merge(InvoiceItem.grouped_total_revenue)
    .order(revenue: :desc)
    .limit(item_count)
  end

  def self.top_merchants(merchant_count = 5)

    if merchant_count > Merchant.all.count
      merchant_count = Merchant.all.count
    end

    Merchant.joins(:transactions)
            .select("merchants.*")
            .merge(Transaction.successful)
            .merge(InvoiceItem.grouped_total_revenue)
            .order(revenue: :desc)
            .limit(merchant_count)
  end

  def best_day
    invoices.joins(:transactions)
    .select("invoices.created_at")
    .merge(Transaction.successful)
    .merge(InvoiceItem.grouped_total_revenue)
    .order(revenue: :desc)
    .first.created_at
  end

  def successful_transactions
    transactions.where(result: 0).distinct.count
  end

  def total_revenue
    invoice_items.revenue
  end
end
