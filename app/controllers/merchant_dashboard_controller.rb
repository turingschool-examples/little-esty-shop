class MerchantDashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @top_five_customers = @merchant.top_five_customers
    @invoice_items_ready_to_ship = @merchant.inv_items_ready_to_ship
  end
end