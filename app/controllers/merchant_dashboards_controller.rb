class MerchantDashboardsController < ApplicationController
  def show
    # require 'pry';binding.pry
    @merchant = Merchant.find(params[:merchant_id])
  end
end