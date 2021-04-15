class Merchant::DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items_ready_to_ship = @merchant.invoice_items_ready_to_ship
  end
end
