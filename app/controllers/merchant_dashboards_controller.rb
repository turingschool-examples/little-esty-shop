class MerchantDashboardsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:merchant_id])
    
    @vip_customers = @merchant.top_customers
  end
end