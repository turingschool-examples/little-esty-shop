class Merchant < ApplicationRecord
  has_many :items 

  validates_presence_of :name
  validates_presence_of :created_at
  validates_presence_of :updated_at
end
