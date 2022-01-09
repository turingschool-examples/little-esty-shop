class Merchant < ApplicationRecord

  has_many :items 
  has_many :invoice_items, :through => :items
  has_many :invoices, :through => :invoice_items 
  has_many :customers, :through => :invoices 
  enum status: %i[disabled enabled]

  # def merchants_invoices 
    #   Invoice.select("invoices.*").joins(:invoice_items, :items).where(items: {merchant_id: self.id}).order(created_at: :asc)

    #   self.invoices.order(created_at: :asc)
  # end

  def items_ready_to_ship
    invoice_items.order(created_at: :asc).where(status: 1)
  end

  def merchants_favorite_customers 
    customers.favorite_customers
  end

  def self.enabled_merchants
    where(status: 1)
  end

  def self.disabled_merchants
    where(status: 0)
  end
end
