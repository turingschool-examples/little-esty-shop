class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name

  has_many :invoices
  has_many :transactions, through: :invoices

  def self.top_five_customers
    joins(:transactions)
    .where("result = 'success'")
    .group(:id)
    .select("customers.*, count('transactions.result') as transaction_count")
    .order(transaction_count: :desc)
    .limit(5)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
