class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :merchant_id
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  enum status: {
    enabled: 0,
    disabled: 1
   }

  def create
  end

  def revenue_formatted
    '%.2f' % (revenue_per / 100)
  end

  def item_best_day
    invoices.joins(:invoice_items, :transactions)
    .select('invoices.created_at, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue_per')
    .merge(Transaction.transaction_successful?)
    .group('invoices.created_at')
    .order('revenue_per DESC, invoices.created_at DESC')
    .first
    .created_at
    .strftime("%m/%d/%y")
  end

end
