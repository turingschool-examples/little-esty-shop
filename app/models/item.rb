class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  enum status: {enabled: 0, disabled: 1}

  validates :merchant_id, presence: true, numericality: true
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true

  def self.most_popular_items(merchant)
    joins(invoice_items: {invoice: :transactions}).
    where(transactions: {result: 0}, merchant_id:merchant.id).
    group(:id).
    select('SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue, items.*').
    order('revenue desc').
    limit(5)
  end

  def best_day
    invoices.joins(:invoice_items, :transactions)
    .where(transactions: {result: 0})
    .select("invoices.created_at, (COUNT(invoice_items.item_id = #{id}))")
    .group(:created_at)
    .order(count: :desc, created_at: :desc)
    .limit(1)
  end
end
