class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items

  def top_5_customers
    
  end
end
