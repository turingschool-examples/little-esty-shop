class MerchantDashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @customers = Customer.top_five_customers
  end
end
