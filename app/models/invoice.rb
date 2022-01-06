class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, :through => :invoices 
  enum status: ["in progress", "completed", "cancelled"]
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.merchants_invoices(merchant)

    joins(:invoice_items, :items).where(items: {merchant_id: merchant.id})

  end

end
