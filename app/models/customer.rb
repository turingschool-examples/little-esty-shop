class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items

  def successful_transaction_count
   transactions.where(transactions: {result: 'success'}).count
  end
end