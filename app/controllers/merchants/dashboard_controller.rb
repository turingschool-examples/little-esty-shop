class Merchants::DashboardController < ApplicationController
  def index
   @merchant = Merchant.find(params[:merchant_id])
   @ready_merchant_items = @merchant.items_not_yet_shipped
  end
end