class Customer < ApplicationRecord
  has_many :invoices

  validates_presence_of :first_name
  validates_presence_of :last_name

  def self.top_customers
    # require 'pry' ; binding.pry
    # Customer.distinct.select("customers.*").joins(invoices: :transactions).order('transactions.count').where("transactions.result" => 1).limit(5)
  end
end
