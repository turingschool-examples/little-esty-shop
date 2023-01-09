class MerchantDashboardsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:merchant_id])
    
    @vip_customers = @merchant.top_customers

    @all_merchant_unshipped_items = @merchant.unshipped_items
  end
end