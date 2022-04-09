class Merchant < ApplicationRecord
  validates :name, presence:true
  validates_inclusion_of :enabled, in: [true, false]

  has_many :items
end
