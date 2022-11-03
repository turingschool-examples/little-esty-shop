class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name

  def top_five_customers
    self.customers.joins(invoices: :transactions)
                      .select('customers.id, customers.first_name, customers.last_name, count(transactions) as count')
                      .where('transactions.result =?','success')
                      .order('count desc')
                      .group('customers.id')
                      .limit(5)
      
  end
end
