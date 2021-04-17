class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :destroy

  enum status: [ 'Enabled', 'Disabled' ]

####### dashboard methods #########









###### item methods ##########









###### invoice methods ##########

end
