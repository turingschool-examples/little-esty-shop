class MerchantDashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @top_five_customers = @merchant.top_five_customers
  end
end