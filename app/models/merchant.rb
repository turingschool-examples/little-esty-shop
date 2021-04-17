class Merchant < ApplicationRecord
  validates :name, presence: true
  validates :status, presence: true

  has_many :items, dependent: :destroy

  enum status: [ :enabled, :disabled ]

####### dashboard methods #########









###### item methods ##########









###### invoice methods ##########

########### admin #############

  def self.enabled?
    enabled
  end

  def self.disabled?
    disabled
  end
end
