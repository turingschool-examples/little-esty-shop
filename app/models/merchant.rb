class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def top_5_customers
    self.customers.top_customers
  end
  
  def top_5_items
    items.select("items.*, unit_price * count(*) AS revenue, mode() within group (order by invoices.created_at desc) AS most_sales_day")
    .left_outer_joins(invoice_items: :invoice)
    .group("items.id").
    order("unit_price * count(*) desc").limit(5)
  end
end