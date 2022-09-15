class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: ["in progress", "completed", "cancelled"]

  def customer_name
    customer.first_name + ' ' + customer.last_name
  end

  def total_revenue
    revenue = 0
    invoice_items.each do |ii|
      revenue += ii.unit_price * ii.quantity
    end
    revenue
  end
end
