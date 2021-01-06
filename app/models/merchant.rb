class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  def favorite_customers
    self.customers.joins(invoices: :transactions).where("transactions.result = 0").select("customers.*, count(*)").group("customers.id").order(count: :desc).limit(5)
  end
end