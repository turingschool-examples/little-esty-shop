class MerchantsDashboardController < ApplicationController

  def index
    @merchant = Merchant.find(params[:id])

    # require "pry"; binding.pry
  end

end
