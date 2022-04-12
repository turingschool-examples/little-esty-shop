class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :items
  has_many :customers, through: :invoices

  def top_5_customers
    # binding.pry
    customers.joins(invoices: :transactions)
      .select('customers.*, count(transactions) as successful_transactions')
      .where('transactions.result = ?', "success")
      .group(:id)
      .order('successful_transactions desc')
      .limit(5)
  end

  def top_five_items
    customers.joins(invoices: :transactions).select('items.*, (invoice_items.unit_price * invoice_items.quantity) AS inv_total').where("transactions.result LIKE 'success'")
    .order('total_rev desc')
    .limit(5)
  end
end
