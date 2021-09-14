class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  def favorite_customers
    items.select('customers.*, COUNT(transactions.result) as purchases')
         .joins(invoices: [:customer, :transactions])
         .where('transactions.result = ?', 0)
         .group('customers.id')
         .order(purchases: :desc)
         .limit(5)

    # Customer
    #   .select("customers.*, COUNT(transactions.result) as purchases")
    #   .joins(invoices: [:items, :transactions])
    #   .group(:id)
  end

  def top_five_items

    items.joins(invoices: :invoice_items)
         .joins(transactions: :invoices)
require "pry"; binding.pry
         #.where("transaction.result = ?", 0)
         #.select(item.*,sum(invoice_items.unit_price*invoice_items.quantity)as revenue)
         #.group(:id)
         #.order(revenue: :desc)
         #.limit(5)
  end
end
