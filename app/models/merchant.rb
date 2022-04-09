class Merchant < ApplicationRecord
  has_many :items

  validates_presence_of(:name)

  def method_name

  end

end
