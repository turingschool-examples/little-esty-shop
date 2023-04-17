class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, -> { distinct }, through: :invoice_items
  has_many :transactions, -> { distinct }, through: :invoices
  has_many :customers, -> { distinct }, through: :invoices

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true

  def find_sold_price(invoice)
    invoice_items.where(invoice_id: invoice.id).pluck(:unit_price)
  end

  def quantity_sold(invoice)
    invoice_items.where(invoice_id: invoice.id).pluck(:quantity)
  end

  def invoice_item_status(invoice)
    invoice_items.where(invoice_id: invoice.id).pluck(:status)
  end

  def paid_invoices
    invoices.joins(:transactions).where(transactions: {result: "success"})
  end

  def total_revenue
    paid_invoices.select("SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue").order(revenue: :desc).first.revenue
  end

  def top_selling_date
    paid_invoices.select("invoices.*").select("SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue").group("invoices.id").order(revenue: :desc, created_at: :desc).first.created_at
  end
end
