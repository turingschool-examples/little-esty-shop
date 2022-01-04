class Merchant < ApplicationRecord
  has_many(:items)

  def favorite_customers
    binding.pry
  end
end
