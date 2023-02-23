class Merchant < ApplicationRecord
	validates :name, presence: true
	enum status: [ "active", "disabled" ]
  has_many :items

  def top_five_customers
    binding.pry
  end
end
