class Invoice < ApplicationRecord
  enum status: { 'in progress' => 0, cancelled: 1, completed: 2 }
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

  def self.not_shipped
    invoice_items = InvoiceItem.all
    invoice_items.where("status != 2")
  end

  # def not_shipped
  #   invoice_ids = InvoiceItem.where("status != 2")
  #   # .pluck(:invoice_id)
  #   # invoice_items.where("status != 2")
  # end
end
