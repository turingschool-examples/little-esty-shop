class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :name

  def top_five_customers
    # x = customers.joins(:transactions).where(result: "success")
    # x = customers.joins(:invoices).where(status: 0)
    
  end
end