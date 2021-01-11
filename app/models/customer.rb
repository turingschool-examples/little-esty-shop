class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name

  has_many :invoices, dependent: :destroy
  has_many :merchants, through: :invoices

  def self.top_customers
    self.joins(invoices: :transactions)
      .where('transactions.result = ?', "success")
      .select("concat(first_name, ' ', last_name) as full_name, count(transactions) as successful_transactions")
      .group('full_name')
      .order('successful_transactions desc')
      .limit(5)
  end
end
