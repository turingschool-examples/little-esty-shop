class Item < ApplicationRecord 
  belongs_to :merchant 
  has_many :invoice_items 
  has_many :invoices, through: :invoice_items 

  def date_with_most_sales
    invoices
    .select("invoices.created_at, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue")
    .order("invoices.created_at desc")
    .group("invoices.created_at")
    .last
    .created_at
    .strftime("%m/%d/%Y")
  end
end 

