class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices, through: :items

  def most_popular_items
    
  end
end
