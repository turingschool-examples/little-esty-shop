class Merchant < ApplicationRecord
  self.primary_key = :id

  has_many :items, dependent: :destroy
end
