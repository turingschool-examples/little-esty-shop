class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  has_many :discounts, through: :merchant

  validates_presence_of :name, :description, :unit_price

  enum status: { 'disabled' => 0, 'enabled' => 1 }

  def best_sales_date
    invoices
    .joins(:invoice_items)
    .select("invoices.*, MAX(invoice_items.quantity) AS most_sold")
    .group(:id)
    .order(most_sold: :desc)
    .first
    .created_at
    .strftime("%a, %d %b %Y")
  end
end
