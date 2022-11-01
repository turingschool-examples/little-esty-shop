class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
    @favorite_customers = @merchant.top_5_customers
  end
end
