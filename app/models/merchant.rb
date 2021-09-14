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
end