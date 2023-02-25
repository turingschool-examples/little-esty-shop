class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  enum status: [ "in progress", "completed", "cancelled" ]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def self.best_date_sales(item_id) #US 13 Iteration 1
    require 'pry'; binding.pry
    select('invoices.*, SUM(invoice_items.unit_price* invoice_items.quantity) as revenue_generated')
      .joins(:invoice_items)
      .where(invoice_items: {item_id: item_id})
      .group(:id)
      .order('revenue_generated DESC')
      .limit(1)
  end
end

