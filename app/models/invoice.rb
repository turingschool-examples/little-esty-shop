class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: [:cancelled, 'in progress', :completed]

  def self.admin_incomplete_invoices
    Invoice.select('invoices.*, invoice_items.invoice_id as number')
    .joins(:invoice_items)
    .where('invoice_items.status != 2')
    .order(:created_at)
    .uniq
  end



  #Merchant.select('merchants.*', 'transactions.result', 'invoices.*').joins(:transactions) -- method to get top 5 revenue merchants

  def self.merchant_invoices(id)
    joins(:items)
    .select('invoices.*')
    .where('merchant_id = ?', id).distinct
  end

  def merchant_items(id)
    items.where('merchant_id = ?', id).select('items.name, items.unit_price, invoice_items.quantity, items.merchant_id, invoice_items.status as order_status')
  end

  def total_revenue(merchant_id)
    merchant_items(merchant_id).sum('quantity * items.unit_price') / 100.00
  end

end
