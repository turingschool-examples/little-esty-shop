class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates_presence_of :quantity_threshold, :quantity_threshold
  validates :quantity_threshold, :quantity_threshold, :inclusion => {:in => [1,100]}

end