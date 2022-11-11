class Discount < ApplicationRecord
  belongs_to :merchant

  validates :quantity_threshold, :percentage_discount, presence: true
end