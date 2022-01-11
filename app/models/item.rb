class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  enum status: { Disabled: 0, Enabled: 1 }

  def most_revenue
    invoices.joins(:invoice_items, :transactions).where(transaction: { result: 0 })
    # require "pry"; binding.pry
    .select('invoices.created_at, SUM(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
    .group(:id)
    .order(total_revenue: :desc)
    .first.created_at
  end
end
