class Merchant < ApplicationRecord
  validates :name, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true

  has_many :items
end
