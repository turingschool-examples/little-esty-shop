class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many:items
  # has_many :invoices
  # has_many :customers, through: :invoices 

  def top_5_customers
    require "pry"; binding.pry
  end
end
