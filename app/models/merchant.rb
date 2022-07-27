class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items 
  has_many :invoices, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices


  def top_5
    binding.pry 
    associations = self.items.select('customer_id, count(result) as success_count').joins(invoices: :transactions).where(transactions: { result: 'success' }).group(:customer_id).order('success_count desc').limit(5)
    associations.map do |item| 
      Customer.find(item.customer_id)
    end
  end
end