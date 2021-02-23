class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  validates_presence_of :name

  enum status: [:enabled, :disabled]
end
