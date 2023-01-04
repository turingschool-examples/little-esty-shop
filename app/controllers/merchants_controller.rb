class MerchantsController < ApplicationController

  def show
    
    @merchant = Merchant.find(params[:merchant_id])
    @merchant.top_five_customers
  end
end