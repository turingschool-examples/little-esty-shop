class Customer < ApplicationRecord

  has_many :invoices, dependent: :destroy

  validates_presence_of :first_name
  validates_presence_of :last_name

  def self.top_customers
    joins(invoices: :transactions)
      .where(transactions: {result: 'success'})
      .select('customers.*, count(result) as count')
      .group(:id)
      .order(count: :desc, first_name: :asc)
      .limit(5)
  end
end
