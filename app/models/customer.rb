class Customer < ApplicationRecord
  has_many :invoices

  def self.top_customers(merchant_id)
    select('count(customers.id), customers.*').joins(invoices: :transactions).joins(invoices: :items).where('transactions.result = 0').where('items.merchant_id = ?', merchant_id).group(:id).order('count(customers.id) desc').limit(5)
  end
end
