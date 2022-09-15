class Merchant < ApplicationRecord
  enum status: ["Enabled", "Disabled"]
  validates_presence_of :name
  validates_presence_of :status, inclusion: ["Enabled", "Disabled"]
  has_many :items
end