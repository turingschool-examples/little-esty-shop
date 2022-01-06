class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def top_customers
     transactions.joins(invoice: :customer)
    .where('result =?',2)
    .select('customers.*,count(transactions) as count_transaction')
    .group('customers.id')
    .order(count: :desc).limit(5)
  end

  def items_ready_ship
    invoice_items.where('status = 1')

  end
end
