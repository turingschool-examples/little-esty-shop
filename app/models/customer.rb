class Customer < ApplicationRecord
  has_many :invoices

  def self.top_customers
    joins(invoices: :transactions)
  end
end
