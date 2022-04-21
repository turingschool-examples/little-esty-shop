class Merchant < ApplicationRecord
  validates :name, presence: true
  validates_inclusion_of :enabled, in: [true, false]

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def enabled_items
    Item.where(merchant_id: self.id).where(enabled: "enabled")
  end

  def disabled_items
    Item.where(merchant_id: self.id).where(enabled: "disabled")
  end

  def popular_items
    Item.joins(invoice_items: {invoice: :transactions})
        .where(transactions: {result: 0}, merchant_id: self.id) #might not need merch id
        .group(:id)
        .select('SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue, items.*')
        .order('revenue desc')
        .limit(5)

  def self.enabled_check(check)
    where(enabled: check).all
  end

  def total_revenue
    invoice_items.sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def self.top_sellers
    joins(:invoice_items, :invoices, :transactions)
<<<<<<< HEAD
      .select("invoice_items.quantity * invoice_items.unit_price AS total_price, merchants.*")
      .where("transactions.result = 0")
      .order(total_price: :desc)
      .limit(5)
  end

  def items_ready_to_ship
    invoice_items.joins(:invoice).where(status: [0, 1])
  end

  def self.best_day(id)
    joins(:invoice_items, :invoices)
      .select("invoice_items.quantity * invoice_items.unit_price AS total_price, invoices.created_at AS invoice_date")
      .where("merchants.id = ?", id)
=======
    .select("invoice_items.quantity * invoice_items.unit_price AS total_price, merchants.*")
    .where("transactions.result = 0")
    .order(total_price: :desc)
    .limit(5)
  end

  def items_ready_to_ship
    invoice_items.joins(:invoice)
      .where(status: [0, 1])
      .group(:id)
      .order(created_at: :asc)
>>>>>>> 1504b172fbe457e938a3add614a3def565442f78
  end
end
