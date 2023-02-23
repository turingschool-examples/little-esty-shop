class Merchant < ApplicationRecord
	validates :name, presence: true
	enum status: { active: 0, disabled: 1 }
end
