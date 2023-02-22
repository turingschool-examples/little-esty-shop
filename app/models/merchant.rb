class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items


  def top_five_customers
    require 'pry'; binding.pry
  end
end
