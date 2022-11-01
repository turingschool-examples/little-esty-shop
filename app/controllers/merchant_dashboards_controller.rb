class MerchantDashboardsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_top_five = Customer.top_five_customers_for(params[:merchant_id])
  end
end