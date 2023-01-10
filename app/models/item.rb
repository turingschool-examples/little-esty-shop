class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  validates_presence_of :name, :description, :unit_price
  validates_numericality_of :unit_price

  def unit_price_to_dollars
    unit_price.to_f / 100
  end

  def self.dollars_to_unit_price(dollars)
    (dollars.to_f * 100).to_i
  end

  def best_day_by_revenue
    invoices.joins(:transactions)
            .where(transactions: { result: 'success' })
            .select('date(invoices.created_at) as invoice_date, sum(invoice_items.unit_price * invoice_items.quantity) as total_date_revenue')
            .group('invoice_date')
            .order('total_date_revenue DESC', 'invoice_date DESC')
            .limit(1)
            .first
            .invoice_date.strftime('%-m/%-d/%Y')
  end
end
