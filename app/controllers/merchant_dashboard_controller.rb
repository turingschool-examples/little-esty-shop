class MerchantDashboardController < ApplicationController
  def dashboard
    @merchants = Merchant.all
    @top_customers = Customer.top_five_customers
  end
end
