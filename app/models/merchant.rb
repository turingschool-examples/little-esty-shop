class Merchant < ApplicationRecord
  has_many :items 
  has_many :invoice_items, :through => :items
  has_many :invoices, :through => :invoice_items 
  has_many :customers, :through => :invoices 

  # def merchants_invoices 
    #   Invoice.select("invoices.*").joins(:invoice_items, :items).where(items: {merchant_id: self.id}).order(created_at: :asc)

    #   self.invoices.order(created_at: :asc)
  # end

  def items_ready_to_ship
    invoice_items.order(created_at: :asc).where(status: 1)
  end

  def favorite_customers 
    Customer.select("customers.*, count(customers.id) as count").joins(:invoices, :transactions).joins(:invoice_items, :items).where(items: {merchant_id: self.id}).group("customers.id").limit(5).order("count")
  end
end
