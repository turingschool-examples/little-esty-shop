# app/models/invoice

class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :transactions, dependent: :destroy
  has_many :merchants, through: :items

  def self.filter_by_unshipped_order_by_age
    joins(:invoice_items).distinct.select("invoices.id, invoices.created_at").where.not(invoice_items: {status: 'shipped'}).order(:created_at)
  end

  # def self.all_merchant_invoices
  #   # returns all invoices that include at least one of the merchant's item 

  #   joins(:merchants, :items).where('merchants.id = items.merchant_id').distinct
  # end
end
