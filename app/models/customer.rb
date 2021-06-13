class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices


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
    joins(:transactions, :merchants)
    .where('transactions.result = ?', 1)
    .where('merchants.id = ?', merchant_id)
    .select('customers.*')
    .group('customers.id')
    .order('transactions.count desc')
    .limit(5)
  end

  def top_successful_transactions
    transactions.where(result: 1).order(:desc).count
  end
end
