class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :bulk_discounts, through: :merchant

  validates_presence_of :name, :description, :unit_price, :status

  def unit_price_to_dollars
    self.unit_price / 100.00
  end


  def total_revenue
    invoice_items.sum("quantity * unit_price").to_s.rjust(3, "0").insert(-3, ".")
  end

  def best_date
    invoices.joins(:transactions, :invoice_items)
            .where('transactions.result = ?', 'success')
            .select('max(invoice_items.quantity), invoices.created_at')
            .group('invoices.created_at')
            .pluck('invoices.created_at')
            .first
  end
end
