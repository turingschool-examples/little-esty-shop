class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price
end
