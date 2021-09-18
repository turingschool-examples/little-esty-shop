class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, through: :items

  def favorite_customers
    invoices.top_five_customers
    # top_five = items.joins(invoices: :transactions).where(transactions: {result: 'success'}).select('invoices.customer_id, COUNT(transactions.*) as t_count').order('COUNT(transactions.*) DESC').group(:customer_id).limit(5)

  end

  def enabled_items
    items.enabled
  end

  def disabled_items
    items.disabled
  end
end
