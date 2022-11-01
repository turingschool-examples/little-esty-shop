class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.top_five_customers_for(merchant_id)
    self.select(:id, :first_name, :last_name, "count(transactions.*) AS num_transactions")
        .joins(invoices: [:transactions, :items])
        .where("transactions.result = 'success'")
        .where("items.merchant_id = ?", merchant_id)
        .group(:id)
        .order(num_transactions: :desc)
        .limit(5)
  end
end

# @merchant.customers.select(:id, :first_name, :last_name, "count(transactions.*) AS num_transactions").joins(invoices: [:transactions, :items]).where("transactions.result = 'success'").group(:id).order(num_transactions: :desc).limit(5)

# Customer.select(:id, :first_name, :last_name, "count(transactions.*) AS num_transactions").joins(invoices: [:transactions, :items]).where("transactions.result = 'success'").where("items.merchant_id = ?", merchant_id).group(:id).order(num_transactions: :desc).limit(5)