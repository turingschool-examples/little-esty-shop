class MerchantsController < ApplicationController
  def dashboard
    @merchant = Merchant.find(params[:merchant_id])
    @favorite_customers = @merchant.favorite_customers
  end
end
