class DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @top_5_customers = @merchant.top_5_customers
  end
end
