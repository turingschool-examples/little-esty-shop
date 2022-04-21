class Merchant < ApplicationRecord
  validates :name, presence: true
  validates_inclusion_of :enabled, in: [true, false]

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.enabled_check(check)
    where(enabled: check).all
  end

  def total_revenue
    invoice_items.sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def self.top_sellers
    joins(:invoice_items, :invoices, :transactions)
      .select("invoice_items.quantity * invoice_items.unit_price AS total_price, merchants.*")
      .where("transactions.result = 0")
      .order(total_price: :desc)
      .first(5)
  end

  def items_ready_to_ship
    invoice_items.joins(:invoice)
      .where(status: [0, 1])
      .group(:id)
      .order(created_at: :asc)
  end
end
