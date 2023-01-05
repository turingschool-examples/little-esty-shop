class Merchant < ApplicationRecord 
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.top5(id)
    Customer
    .joins(:merchants, :transactions)
    .where("transactions.result = 0 AND merchants.id = #{id}")
    .group(:id)
    .select('first_name, last_name, count(customers) AS transactions_count')
    .order(transactions_count: :desc)
    .limit(5)
    
    # .select('count(customers) AS transactions_count')
    # .group('customers {:id}') 
    # .order(transactions_count: :desc)
  end
end

#helper method to turn 

# customers names, where Transaction


# Customer
# .joins(invoices: [:transactions, { items: :merchant }])
# .where("transactions.result = 0 AND merchants.id = #{id}")
# .select('customers.*, count(transactions) AS transactions_count')
# .group('id')
# .order(transactions_count: :desc)
# .limit(5)