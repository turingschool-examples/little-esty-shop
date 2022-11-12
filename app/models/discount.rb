class Discount < ApplicationRecord
    belongs_to :merchant
    
    def self.by_id(merchant)
        Discount.where("merchant_id = #{merchant.id}")
    end
end