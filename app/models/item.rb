class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name, :description, :unit_price, :status

  enum status: [:enabled, :disabled]

  def unit_price_to_dollars
    unit_price_in_cents = self.unit_price || 0
    dollars = unit_price_in_cents / 100.0
    format('%.2f', dollars)
  end

  def enabled
    self.status == 'enabled'
  end

  def disabled
    self.status == 'disabled'
  end

  def self.top_five_by_revenue(merchant)
    joins(invoice_items: { invoice: :transactions })
      .where(merchant_id: merchant.id, transactions: {result: Transaction.results[:success]})
      .group('items.id')
      .select('items.*, SUM(invoice_items.quantity * invoice_items.unit_price/100) AS revenue')
      .order('revenue DESC')
      .limit(5)
  end

  def top_selling_date
    self.invoices.joins(:transactions, :invoice_items)
      .where(transactions: {result: Transaction.results[:success]})
      .group('invoices.created_at')
      .order(Arel.sql('SUM(invoice_items.quantity * invoice_items.unit_price/100) DESC'))
      .limit(1)
      .pluck(:created_at)
      .first
      .strftime("%A, %B %d, %Y")
  end
end
