class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :created_at
  validates_presence_of :updated_at
  validates_presence_of :id
  validates_presence_of :merchant_id
  belongs_to :merchant
  
  def create
  end
end
