class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices

  def merchant_invoices
    invoices
  end

  def favorite_customers
    require "pry"; binding.pry
    transactions
  end
end
