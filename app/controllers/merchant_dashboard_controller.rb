class MerchantDashboardController < ApplicationController
  def dashboard
    @merchants = Merchant.all
  end
end
