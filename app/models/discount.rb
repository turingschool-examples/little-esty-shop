class Discount < ApplicationRecord
  belongs_to :merchant
  validates :quantity_threshold, :percentage_discount, presence: true

  def self.avaliable_discounts(item)
    self.where(merchant_id: item.merchant_id)
  end
end