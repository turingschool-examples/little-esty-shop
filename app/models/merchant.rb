class Merchant < ApplicationRecord
  has_many :items
  validates :name, presence: true

  def self.test
  end
end
