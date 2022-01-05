class Merchant < ApplicationRecord
  has_many :items

  enum status: {enable: 0, disable: 1}
end
