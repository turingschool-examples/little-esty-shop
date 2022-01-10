class Merchant < ApplicationRecord
  has_many :items
  validates :name, presence: true

  enum status: [:disabled, :enabled]
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  validates :name, presence: true

  def top_customers
    Customer.joins(invoices: :transactions)
      .select("customers.*, count(transactions.id) as transaction_id_count")
      .limit(5)
      .group(:id)
      .order(transaction_id_count: :desc)
      .where(transactions: { result: 1 } )
  end

  def ready_items
    Item.joins(:invoice_items)
      .group(:id)
      .where(invoice_items: {status: "packaged"})
      .select(:name, :id)
      .limit(5)
      .order(:created_at)
  end

  def top_items
    Item.joins(invoices: :transactions)
        .where(invoices: {status: 1}, transactions: {result: 1})
        .select("items.id, items.name, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
        .group(:id)
        .order("revenue desc")
        .limit(5)
  end

  def filter_item_status(status_enum)
    items.where(status: status_enum)
  end

  def self.filter_merchant_status(status_enum)
    where(status: status_enum)
  end
end
