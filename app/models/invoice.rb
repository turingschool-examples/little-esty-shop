class Invoice < ApplicationRecord
  enum status: [:cancelled, :completed, :in_progress]
  
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.incomplete_invoices
    where("status = 2").order(:created_at)
  end

  def merchant_items(merchant)
    self.items.where(items: { merchant_id: merchant.id } ).distinct
  end

  def calculate_invoice_revenue(merchant)
    self.invoice_items.sum("unit_price * quantity")
  end
end



# Item.joins(invoices: :transactions)
# .group(:id, :name)
# .where( transactions: {result: 1}, merchant_id: self.id)
# .select(:name, :id, "sum(invoice_items.unit_price*quantity) as revenue")
# .order(revenue: :desc)
# .limit(5)