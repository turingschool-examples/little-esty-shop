class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy

  def top_customers
    require "pry"; binding.pry
  end
end
