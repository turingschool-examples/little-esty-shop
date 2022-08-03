class Item < ApplicationRecord
  enum status: { Disabled: 0, Enabled: 1 }

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  def best_date
    self.invoices
        .joins(:transactions)
        .where(transactions: {result: 1})
        .select('invoices.id, invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
        .group(:id)
        .order(revenue: :desc)
        .limit(1)
        .first
        .formatted_date
  end

end
