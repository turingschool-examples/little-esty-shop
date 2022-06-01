class DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    # require "pry"; binding.pry
  end
end
