class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  enum status: { Disabled: 0, Enabled: 1 }

  def most_revenue
    invoices.joins(:invoice_items).where('invoices.status = 2')
    .select('invoices.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_rev')
    .group(:id)
    .order(total_rev: :desc)
    .first.created_at.to_date
  end
end
