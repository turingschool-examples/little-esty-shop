class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true

  enum status: { disable: 0, enable: 1 }

  def self.enable_items
    where(status: 1)
  end

  def self.disable_items
    where(status: 0)
  end

  def self.top_popular_items
    joins(invoices: [:invoice_items, :transactions])
    .where('transactions.result = ?', 1)
    .select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue_generated")
    .group(:id)
    .order('total_revenue_generated desc')
    .limit(5)
  end
end
