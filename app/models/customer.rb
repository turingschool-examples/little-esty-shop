class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices
  has_many :items, through: :invoices
  validates_presence_of :first_name, :last_name

  def self.top_customers
    joins(invoices: [:transactions])
    .group(:id)
    .where("transactions.result=0")
    .select("customers.*, count(transactions) as success_count")
    .order("success_count desc")
    .limit(5)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
