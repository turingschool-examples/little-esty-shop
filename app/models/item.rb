class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, :description, :unit_price, presence: true

  def self.inactive
    where('status = ?', 'Inactive')
  end

  def self.active
    where('status = ?', 'Active')
  end

  def top_sales_date
    invoices
    .select("date_trunc('day', invoices.created_at) as day, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue")
    .group('day')
    .order(total_revenue: :desc)
    .first
    .day
    .strftime("%m/%d/%Y")
  end
end
