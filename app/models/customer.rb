class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name
  has_many :invoices
  has_many :transactions, through: :invoices 
  has_many :invoice_items, through: :invoices 
  has_many :items, through: :invoice_items 
  has_many :merchants, through: :items 
  has_many :discounts, through: :merchants 

  def self.top_five 
    joins(invoices: :transactions)
    .where(transactions: {result: :success})
    .group(:id)
    .select("customers.*, count(transactions) as trans_count") ##when i DIDN'T use an alias here this didn't pass for some reason? -GJ
    .order("trans_count desc")
    .limit(5)
  end
end
