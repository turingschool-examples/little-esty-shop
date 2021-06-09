class Customer < ApplicationRecord
  has_many :merchants_customers
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
end
