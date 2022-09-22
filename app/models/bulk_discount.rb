class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates_presence_of :percentage_discount, :quantity_threshold
  validates :percentage_discount, :inclusion => {:in => [1,100]}
  validates_numericality_of :percentage_discount, :quantity_threshold

end