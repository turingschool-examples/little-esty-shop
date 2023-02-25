class Merchant < ApplicationRecord
  has_many :items

  validates :name, presence: true

  enum status: ["Enabled", "Disabled"]
end
