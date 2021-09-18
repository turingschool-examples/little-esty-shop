class Invoice < ApplicationRecord
  belongs_to :customer
  has_many   :transactions,  dependent: :destroy
  has_many   :invoice_items, dependent: :destroy
  has_many   :items, through: :invoice_items

  def self.top_five_customers
    Customer.joins(invoices: :transactions).where(transactions: {result: 'success'}).select('customers.*, COUNT(transactions.*) as t_count').order('COUNT(transactions.*) DESC').group(:id).limit(5)
  end
end
