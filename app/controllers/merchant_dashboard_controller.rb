class MerchantDashboardController < ApplicationController
  def dashboard
    @merchants = Merchant.all
    require "pry"; binding.pry
  end
end
