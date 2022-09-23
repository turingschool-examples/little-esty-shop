class Invoice < ApplicationRecord
  enum status: [:cancelled, :completed, :in_progress]
  
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  def self.incomplete_invoices
    where("status = 2").order(:created_at)
  end

  def merchant_items(merchant)
    self.items.where(items: { merchant_id: merchant.id } ).distinct
  end

  def calculate_invoice_revenue
    self.invoice_items.sum("quantity*unit_price")
  end

  def calculate_discounted_invoice_revenue
    # items.joins(merchant: :bulk_discounts).select(:id, "bulk_discounts.*, invoice_items.*, sum(invoice_items.quantity*(invoice_items.unit_price/(bulk_discount.percentage_discount * 0.01)) as discounted_revenue").order("discounted_revenue desc").group(:id).where("invoice_items.quantity >= bulk_discount.quantity_threshold")
    #this is a table of all of this invoices bulk discounts
    33333
  end

end
