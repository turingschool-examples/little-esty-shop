class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.top_five_customers
    require "pry"; binding.pry
    joins(invoices: :transactions).where(transactions: { result: 0})
  end
end
