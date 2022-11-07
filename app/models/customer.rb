class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def self.top_5_by_successful_transactions
    joins(:transactions)
    .where(transactions: {result: 1})
    .group(:first_name, :last_name)
    .order('count_id desc')
    .limit(5)
    .count('id')
  end
end
