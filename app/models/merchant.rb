class Merchant < ApplicationRecord
  validates :name, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true
  validates :id, presence: true
  has_many :items
end
