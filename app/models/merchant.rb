class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  # def top_5_customers
  #   require 'pry'; binding.pry
  #   transactions.select('customers.*, count(transactions.result = 1) as transaction_count')
  #               .group(:id)
  #               .order('transaction_count DESC')
  #               .limit(5)
  # end

    # customers.top_5
    
    # top_5 = transactions
      # .select('invoices.customer_id, count(transactions.result = 1) as transaction_count')
      # .group('invoices.customer_id')
      # .order('transaction_count DESC')
      # .limit(5)

    #   customers.where(id: top_5.map { |transaction| transaction[:customer_id]}).distinct
end
