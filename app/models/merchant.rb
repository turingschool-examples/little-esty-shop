class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items 
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices


  def top_5
    # test = customers
    # .joins(invoices: :transactions)
    # .where(transactions: { result: 'success'})
    # .select('customers.*, count(transactions.result) as transaction_total')
    # .group(:id)
    
    customers
    .joins(:transactions)
    .where(transactions: { result: 'success' })
    .group(:id)
    .select('customers.*, count(*) as success_count')
    .order('success_count desc')
    .limit(5)
  end

  def unshipped_items
    # items.joins(:invoice_items).where(invoice_items: { status: 'packaged' }).select('items.*, invoice_items.invoice_id as invoice_id').order(:invoice_id)
    invoice_items.joins(:invoice).where(status: 1).order("invoices.created_at")
  end
  
  def get_invoice_items(invoice_id)
    in_items = InvoiceItem.where(item_id: items.pluck(:id), invoice_id: invoice_id)
  end

  def total_revenue(invoice_id)
    get_invoice_items(invoice_id).sum("quantity * unit_price")
  end
end