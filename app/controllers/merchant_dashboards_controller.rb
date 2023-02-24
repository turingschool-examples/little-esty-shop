class MerchantDashboardsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @top_five_merchant_customers = @merchant.top_five_merchant_customers
  end
end