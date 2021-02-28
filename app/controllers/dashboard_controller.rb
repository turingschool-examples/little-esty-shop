class DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_top_five_customers = @merchant.top_five_customers
  end
end
