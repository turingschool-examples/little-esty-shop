class Merchant::DashboardController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @top_customers = Customer.top_customers_for_merchant(@merchant.id)
  end
  
end
