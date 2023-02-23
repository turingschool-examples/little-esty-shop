class Merchant < ApplicationRecord
	validates :name, presence: true
end
