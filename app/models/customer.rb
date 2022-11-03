class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :first_name
  validates_presence_of :last_name

  def self.top_five_customers
    Customer.select(:id, :first_name, :last_name, 'count(transactions.*) as number_transactions').joins(:transactions).where('transactions.result =?','success').group(:id).order('number_transactions desc').limit(5)
  end

  def transaction_ct(result)
    transactions.where(result: result).count
  end
end