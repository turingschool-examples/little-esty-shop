class Customer < ApplicationRecord
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :merchants, through: :items

  def self.top_five
    joins(:transactions)
    .group(:id)
    .where('transactions.result = ?', 'success')
    .order('count(customers.id) desc')
    .limit(5)
  end
end
