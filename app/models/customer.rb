class Customer < ApplicationRecord 
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices
  has_many :items, through: :invoices

  def self.successful_transactions
    joins(:transactions).where("transactions.result = 'success'")
  end

  def self.order_by_purchases
    select("customers.*, COUNT(invoices.customer_id) as purchases").group("customers.id").order("purchases desc, customers.id")
  end

  def self.top_customers
    successful_transactions.order_by_purchases.first(5)
  end
end