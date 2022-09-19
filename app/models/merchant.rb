class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  enum active_status: { disabled: 0, enabled: 1 }

  def items_not_shipped_sorted_by_date
    invoices.where.not(invoice_items: {status: 2}).order("invoices.created_at")
  end

  def self.active
    where(active_status: :enabled)
  end

  def self.inactive
    where(active_status: :disabled)
  end

  def invoices_distinct_by_merchant
    invoices.group(:id).distinct
  end

  def total_revenue
    items.sum do |item|
      item.invoices.invoice_successful_trans.sum do |invoice| 
        item.price_sold(invoice.id) * item.quantity_purchased(invoice.id)
      end  
    end 
  end  

  def self.top_5_order_by_revenue
    joins(invoice_items:[invoice:[:transactions]]).group(:id).where(transactions: { result: 0 }).select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue').order('total_revenue desc').limit(5)
  end
end