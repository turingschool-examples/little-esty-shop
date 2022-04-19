class Customer < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true


  has_many :invoices
  has_many :transactions, through: :invoices

  def self.top_5_customers
    joins(invoices: :transactions)
    .select("customers.*, count(transactions) as successful_transactions")
    .where("transactions.result = ?", "success")
    .group(:id)
    .order("successful_transactions desc")
    .limit(5)
  end
end
