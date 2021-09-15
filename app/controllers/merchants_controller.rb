class MerchantsController < ApplicationController
  def dashboard
    @merchant = Merchant.find(params[:merchant_id])
    @favorite_customers = @merchant.favorite_customers
    # @items_ready_to_ship = @merchant.ready_to_ship
  end
end
