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
    # binding.pry 
    test = customers
    .joins(invoices: :transactions)
    .where(transactions: { result: :success })
    .select('customers.*, count(transactions.result) as success_count')
    .group(:id)
    .order('success_count desc')
    .limit(5)
    # binding.pry 
  end

  def unshipped_items
    # items.joins(:invoice_items).where(invoice_items: { status: 'packaged' }).select('items.*, invoice_items.invoice_id as invoice_id').order(:invoice_id)
    # binding.pry 
    test = invoice_items.joins(:invoice).where(status: 1).order("invoices.created_at")
    # binding.pry 
  end
end