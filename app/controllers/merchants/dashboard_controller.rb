class Merchants::DashboardController < ApplicationController

  def show 
    @merchant = Merchant.find(params[:merchant_id])
    @shippable_items = @merchant.items.not_yet_shipped
  end
end