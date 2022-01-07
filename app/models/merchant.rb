class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def disabled_items
    items.where(status: "Disabled")
  end

  def top_customers
     transactions.joins(invoice: :customer)
    .where('result =?',2)
    .select('customers.*,count(transactions) as count_transaction')
    .group('customers.id')
    .order(count: :desc).limit(5)
  end

  def order_by_invoice
    invoices.order(:created_at)
  end


end
