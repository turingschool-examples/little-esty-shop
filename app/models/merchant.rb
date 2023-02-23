class Merchant < ApplicationRecord
	validates :name, presence: true
	enum status: [ "active", "disabled" ]
  has_many :items
end
