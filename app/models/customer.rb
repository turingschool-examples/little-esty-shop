# app/models/customer

class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  def self.top_five
    joins(:transactions).select("customers.*, CONCAT(customers.first_name, ' ', customers.last_name) as name, count(transactions.*) as num_trans").where("transactions.result = 'success'").group(:id).order("num_trans desc").limit(5).order(:first_name)
  end
  
  def self.top_five_by_merchant(merchant_id)
    joins(:transactions, :merchants).select("customers.*, CONCAT(customers.first_name, ' ', customers.last_name) as name, count(transactions.*) as num_trans").where("transactions.result = 'success' and items.merchant_id = #{merchant_id}").group(:id).order("num_trans desc").limit(5)
  end

  def full_name
    first_name.concat(" ", last_name)
  end
end