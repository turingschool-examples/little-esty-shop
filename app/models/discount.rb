class Discount < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :name, 
                        :threshold, 
                        :percentage
end
