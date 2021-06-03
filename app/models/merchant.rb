class Merchant < ApplicationRecord
  validates_presence_of :name
  #status?
  has_many :items
end
