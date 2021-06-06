class Merchant::DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @top_5_customers_array = @merchant.top_5_customers
    @customers = Customer.all
  end
end
