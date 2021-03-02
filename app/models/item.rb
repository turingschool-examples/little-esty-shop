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

  def best_sales_date
    invoice_items.joins(:invoice)
    .select("invoices.created_at, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue")
    .group("invoices.created_at")
    .order(total_revenue: :desc)
    .first
    .created_at
    .strftime("%m/%d/%Y")
  end
end
