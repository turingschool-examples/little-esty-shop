class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :first_name, :last_name

  def self.top_five
    joins(:transactions)
    .where('result = ?', 1)
    .group(:id)
    .select("customers.*, count(transactions) as sales")
    .order(sales: :desc)
    .limit(5)
  end
end
