class Customer < ApplicationRecord
  validates_presence_of :first_name, presence: true
  validates_presence_of :last_name, presence: true
  
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices

  def self.top_5_by_transaction
    joins(:transactions)
    .where(transactions: {result: 'success'})
    .group(:id)
    .select('customers.*, count(*)')
    .order('count desc')
    .limit(5)
  end
end
