class Merchant < ApplicationRecord
  has_many :items

  def customers
    binding.pry
  end
end
