class Merchant < ApplicationRecord

  enum status: { disabled: 0, enabled: 1 }

  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items, dependent: :destroy
  has_many :invoices, through: :invoice_items, dependent: :destroy
  has_many :customers, through: :invoices, dependent: :destroy
  has_many :transactions, through: :invoices, dependent: :destroy

  def self.find_by_status(merchant_status) 
    Merchant.where(status: merchant_status).order(updated_at: :desc)
  end

  def unshipped_items 
    items.select(
          'items.*,
           invoice_items.invoice_id as invoice_id,
           invoices.created_at as invoice_created_at'
        )
       .joins(invoice_items: :invoice)
       .where(invoices: {status: 0})
       .where.not(invoice_items: {status: 2})    
  end
end