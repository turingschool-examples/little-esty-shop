class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items 
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices


  def top_5
    # test = customers
    # .joins(invoices: :transactions)
    # .where(transactions: { result: 'success'})
    # .select('customers.*, count(transactions.result) as transaction_total')
    # .group(:id)
    
    # binding.pry 
    
    test = customers
    .joins(:transactions)
    .where(transactions: { result: 'success' })
    .group(:id)
    .select('customers.*, count(*) as success_count')
    .order('success_count desc')
    .limit(5)
  end
end