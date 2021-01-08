class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions

  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: [:"in progress", :completed, :cancelled]

  def self.successful_transactions
    
  end

  def self.happy_customers
    where(status: 1).pluck(:customer_id).uniq
  end
end
