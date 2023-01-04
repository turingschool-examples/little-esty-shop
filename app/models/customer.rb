class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  validates_presence_of :first_name, :last_name
  def self.top_5_by_transactions
    Customer.left_joins(:transactions).group(:id).where('transactions.result = ?', 'success').order(Arel.sql('COUNT(transactions) DESC')).limit(5)
  end

  def transactions_count
    transactions.where(result: 'success').count 
  end
end