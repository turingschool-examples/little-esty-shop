class DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_top_five_customers = @merchant.top_five_customers
    @items_ready_to_ship = @merchant.items_ready_to_ship
  end
end
