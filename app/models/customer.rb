class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items

  def self.top_5_by_transactions
    Customer.joins(:transactions)
            .select("customers.*, count(transactions.id)")
            .group(:id)
            .limit(5)  
  end
end