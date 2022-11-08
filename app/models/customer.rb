class Customer < ApplicationRecord
  has_many :invoices 
  has_many :transactions, through: :invoices
  has_many :items, through: :invoices

  def name
    "#{first_name} #{last_name}"
  end

  def self.top_five_customers
    Customer.select("customers.*, count(transactions.*) AS succ_transactions").joins(:transactions).where("transactions.result = 0").group("customers.id").order("succ_transactions DESC").limit(5)
  end
end