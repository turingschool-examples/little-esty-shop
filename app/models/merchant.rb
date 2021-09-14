class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  def favorite_customers
    items.select('customers.*, COUNT(transactions.result = 0) as success')
         .joins(invoices: [:customer, :transactions])
         .group('customers.id')
         .order('success desc')
         .limit(5)
  end
end
