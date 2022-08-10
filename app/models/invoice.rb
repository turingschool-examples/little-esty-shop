class Invoice < ApplicationRecord
  validates_presence_of :status

  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: { "in progress" => 0, "cancelled" => 1, "completed" => 2 }

  def self.incomplete_invoices
    joins(:invoice_items)
    .where.not(invoice_items: { status: 2 })
    .order(:created_at)
    .distinct
  end

  def total_revenue
   invoice_items.sum("unit_price * quantity")
  end

  def discounted
    invoice_items.joins(merchants: :bulkdiscounts)
    .where('invoice_items.quantity >= bulkdiscounts.threshold')
    .select('invoice_items.id, max(invoice_items.quantity * invoice_items.unit_price * (bulkdiscounts.percentage / 100.0)) as total_discount')
    .group('invoice_items.id')
    .sum(&:total_discount)
  end

end
