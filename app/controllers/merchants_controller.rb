class MerchantsController < ApplicationController
  def dashboard
    # require "pry"; binding.pry
    @merchant = Merchant.find(params[:id])
  end
end
