class Invoice < ApplicationRecord
  enum status: { pending: 0, completed: 1 }
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  def customer_name
    customer = Customer.find(customer_id)
    customer.first_name + " " + customer.last_name
  end 

  def invoice_revenue
    (invoice_items.sum("invoice_items.unit_price * invoice_items.quantity"))/100
  end 
end
