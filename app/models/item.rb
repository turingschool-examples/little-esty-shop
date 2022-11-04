class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant 
  has_many :transactions, through: :invoices 

  # def item_revenue
  #   invoice_items.sum("quantity * unit_price")
  # end


  def most_recent_date
    invoices.order(created_at: :desc).limit(1).pluck(:created_at)
  end
end