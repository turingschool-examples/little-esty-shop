class Customer < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :transactions, through: :invoices

  def full_name
    first_name + " " + last_name
  end

  def self.top_customers
    joins(:transactions)
    .where('transactions.result = ?', 'success')
    .group('customers.id')
    .select('customers.*, count(*) as transaction_count')
    .order('transaction_count desc')
    .limit(5)
  end
end
