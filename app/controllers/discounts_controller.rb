class DiscountsController < ApplicationController
    def index 
        @merchant = Merchant.find(params[:merchant_id])
        @discounts = Discount.where("merchant_id = #{@merchant.id}")
    end
end