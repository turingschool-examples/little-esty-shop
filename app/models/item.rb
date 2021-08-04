class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  enum enabled: {enabled: 0, disabled: 1}

  validates :name, presence: true
  validates :unit_price, presence: true

  def self.not_yet_shipped
    Item.joins(:invoices).select("items.name, invoices.id as invoice_id, invoices.created_at as invoice_date")
    .where.not(invoice_items: {status: "shipped"})
    .order("invoice_date asc")
    .as_json(:except => :id)
  end

  def self.most_popular_items
    joins(invoices: :transactions)
    .where("transactions.result = ?", 0)
    .select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .group(:id)
    .order('revenue desc')
    .limit(5)
  end

  def self.best_revenue_day(id)
    joins(invoice_items: {invoice: :transactions})
    .select("sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .where("transactions.result =?", 0)
    .where("items.id =?", id)
    .order(Arel.sql("sum(invoice_items.quantity * invoice_items.unit_price) desc, invoices.created_at desc"))
    .group("invoices.id")
    .pluck("invoices.created_at")
    .first
  end
end
