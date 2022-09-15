class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items

  def items_sorted_by_revenue
    items.
    joins(:invoice_items).
    select('items.*, sum(invoice_items.quantity *invoice_items.unit_price) as revenue').
    group('items.id').
    order(revenue: :desc)
  end

  def top_five_items
    items_sorted_by_revenue.successful_transactions.limit(5)
  end
end