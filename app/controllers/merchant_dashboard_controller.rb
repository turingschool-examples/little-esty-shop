class MerchantDashboardController < ApplicationController
  def dashboard
    @merchants = Merchant.all
    @top_customers = Customer.top_five_customers
    @merchant = Merchant.find(params[:id])
    # @unshipped_items = @merchant.items_not_shipped
  end

  def index 
  end 
end
