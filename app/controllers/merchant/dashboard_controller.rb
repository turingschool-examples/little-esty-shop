class Merchant::DashboardController < ApplicationController

  def index
    # require 'pry'; binding.pry
    @merchant = Merchant.find(params[:merchant_id])
  end
end