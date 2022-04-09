class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
  validates :created_at, presence: true
  validates :updated_at, presence: true
  belongs_to :merchant
end
