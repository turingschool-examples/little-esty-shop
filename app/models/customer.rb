class Customer < ApplicationRecord
  has_many :merchants_customers
  has_many :merchants, through: :merchants_customers
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices


  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.top_5_customers
    joins(:transactions)
    .where('transactions.result = ?', 1)
    .group(:id)
    .order('transactions.count desc')
    .limit(5)
  end

  def number_of_successful_transactions
    transactions.where(result: 1).count
  end

  def self.top_customers(merchant_id)
    joins(:merchants_customers, :transactions, :merchants)
    .where('transactions.result = ?', 1)
    .where('merchants_customers.merchant_id = ?', merchant_id)
    .select('customers.*')
    .group('customers.id')
    .order('transactions.count desc')
    .limit(5)
  end

  def top_successful_transactions(merchant_id)
    Customer.joins(:merchants_customers, :transactions, :merchants)
    .where('transactions.result = ?', 1)
    .where('merchants_customers.merchant_id = ?', merchant_id)
    .where('customers.id = ?', self.id)
    .select('transactions.*')
    .order('transactions.id')
    .distinct
    .count
  end
end
