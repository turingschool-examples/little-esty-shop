class Merchant < ApplicationRecord
  has_many :items
  
  def not_shipped
    items.select("items.*, invoice_items.status as not_shipped").joins(:invoice_items).where.not("invoice_items.status = ?", 2)
    
  end
end
