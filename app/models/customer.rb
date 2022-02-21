class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def self.top_5_customers
    joins(:transactions)
      .where('result = ?', 'success')
      .group(:id)
      .select("customers.*, count('transactions.result') as top_result")
      .order(top_result: :desc)
      .limit(5)
  end
end
