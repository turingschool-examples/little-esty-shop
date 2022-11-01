class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items


  def top_five_customers
    require 'pry'; binding.pry
  end
end