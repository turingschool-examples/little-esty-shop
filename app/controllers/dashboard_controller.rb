class DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @customers = Customer.all
  end
end
