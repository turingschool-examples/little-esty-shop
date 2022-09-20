class Customer < ApplicationRecord
    validates_presence_of :first_name, :last_name

  has_many :invoices
  
  def self.top_5_customers
    joins(invoices: [:transactions]).group(:id).where(transactions: {result: 0}).select('customers.*, count(result) as success_count').order(success_count: :desc).limit(5)
  end

  def self.top_5_cust_by_merch(merch_id)
    joins(invoices:[:transactions, items:[:merchant]]).group(:id).where(merchants: { id: "#{merch_id}" }, transactions: {result: 0}).select('customers.*, count(result) as success_count').order(success_count: :desc).limit(5)
  end
end
