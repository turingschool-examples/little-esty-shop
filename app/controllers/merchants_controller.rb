class MerchantsController < ApplicationController
	
  def dashboard
    @merchant = Merchant.find(params[:id])
    @top_five_customers = @merchant.customers.top_five_customers
  end
end