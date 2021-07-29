class DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items_not_shipped = @merchant.items.not_yet_shipped
  end
end
