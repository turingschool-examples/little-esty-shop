class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items, dependent: :destroy
  has_many :invoices, through: :invoice_items, dependent: :destroy
  has_many :customers, through: :invoices, dependent: :destroy
  has_many :transactions, through: :invoices, dependent: :destroy

  validates_presence_of :name
  validates_presence_of :created_at
  validates_presence_of :updated_at
  enum status: {enable: 0, disable: 1}


  def top_five_customers
    customers.joins(invoices: :transactions)
              .where(transactions: { result: 0})
              .select('customers.*, count(transactions.*) as total_transactions')
              .order(total_transactions: :desc)
              .group('customers.id')
              .limit(5)
  end




  def unique_invoices
    invoices.uniq
  end


  def current_invoice_items(invoice_id)
    invoice_items.where(invoice_id: invoice_id)

  end
end
