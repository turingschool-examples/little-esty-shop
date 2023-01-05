class MerchantDashboardsController < ApplicationController
  def show
    # require 'pry';binding.pry
    @merchant = Merchant.find(params[:merchant_id])

    @vip_customsers = Customer.top_customers
  end
end