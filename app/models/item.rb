class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
  validates :item_status, presence: true, numericality: true

  attribute :item_status, :integer, default: 2

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :bulk_discounts, through: :merchant

  def display_price
    cents = unit_price
    format('%.2f', (cents / 100.0))
  end

  def item_best_day
    invoices.joins(:invoice_items, :transactions)
            .select('invoices.created_at AS date, sum(invoice_items.unit_price * invoice_items.quantity) AS total_item_sales')
            .where('transactions.result =?', 0)
            .group('invoices.created_at')
            .order(total_item_sales: :DESC, date: :DESC)
            .first
            .date
            .strftime('%m/%d/%y')
  end
end
