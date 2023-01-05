class Merchant < ApplicationRecord
    has_many :items, dependent: :destroy
    has_many :invoice_items, through: :items, dependent: :destroy
    has_many :invoices, through: :invoice_items, dependent: :destroy
    has_many :customers, through: :invoices, dependent: :destroy
    has_many :transactions, through: :invoices, dependent: :destroy

  # def self.top_customers
    # require 'pry'; binding.pry
    # Customer.joins(:transactions)
    #         .select(:id, :first_name, :last_name, 'count(transactions.*) as num_transactions' )
    #         .group(:id)
    #         .where(transactions: { result: "success"})
    #         .order("num_transactions desc")
    #         .limit(5)

  #   joins(:transactions)
  #           .where(transactions: { result: "success"})
  #           .group(:id)
  #           .select(:id, :first_name, :last_name, 'count(transactions.results) as num_transactions' )
  #           .order("num_transactions desc")
  #           .limit(5)
  # end

  #   Customer.joins(:transactions)
  #   .where(transactions: { result: "success"})
  #   .select(:id, :first_name, :last_name, 'count(result) as num_transactions')
  #   .group(:id)
  #   .order('num_transactions desc')
  #   .limit(5)
  # end
end