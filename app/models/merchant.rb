class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  def favorite_customers
    Customer.select("customers.*, COUNT(transactions.result) as purchases")
      .joins(invoices: [:items, :transactions])
      .merge(Transaction.purchase)
      .group(:id)
      .order(purchases: :desc)
      .limit(5)
  end

  def items_ready_to_ship
    items.joins(:invoice_items)
        .where.not('invoice_items.status = ?', 2)
  end

  def top_five_items
    items.joins(invoices: [:invoice_items, :transactions])
         .where('transactions.result = ?', 0)
         .select('items.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue')
         .group(:id)
         .order(revenue: :desc)
         .limit(5)
  end

  # def all_invoices
  #   require "pry"; binding.pry
  #   items.joins(:invoices)
  #        .select("invoices.id AS invoice_id, item_id")
  #        .group(:invoice_id)
  #
  # end
end
