class Merchant < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :created_at
  validates_presence_of :updated_at
  validates_presence_of :id
  has_many :items

  def create
  end
end
