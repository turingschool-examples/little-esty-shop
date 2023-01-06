class MerchantDashboardsController < ApplicationController
  def show
    # require 'pry';binding.pry
    @merchant = Merchant.find(params[:merchant_id])

    @vip_customers = Customer.top_customers_for(@merchant)
  end
end