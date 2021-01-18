class MerchantDiscountsController < ApplicationController
  def index
    # binding.pry
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts
  end

  def new

  end
end
