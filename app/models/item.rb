class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def self.enable
    where(enabled: true)
  end

  def self.disable
    where(enabled: false)
  end

  def self.top_5_items
    select("items.*, sum(invoice_items.unit_price * invoice_items.quantity) AS total_revenue")
    .joins(:transactions)
    .where(transactions: {result: :success})
    .group(:id)
    .order(total_revenue: :desc)
    .limit(5)
  end
end
