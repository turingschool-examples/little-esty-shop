class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :destroy

####### dashboard methods #########









####### item methods ##############









###### invoice methods ###########

end
