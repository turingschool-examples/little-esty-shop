class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices

  validates_presence_of :name, :description, :unit_price, :merchant_id
  validates_numericality_of :unit_price, greater_than: 0

  enum status: { disabled: 0, enabled: 1 }

  def top_item_selling_date
    invoices
      .joins(:invoice_items)
      .where('invoice_items.status = 1 OR invoice_items.status = 2')
      .select('invoices.created_at, SUM(invoice_items.quantity * invoice_items.unit_price) AS top_revenue')
      .group('invoices.created_at')
      .order('top_revenue desc', 'invoices.created_at desc')
      .first
      .created_at
  end
end
