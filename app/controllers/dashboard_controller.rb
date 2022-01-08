class DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @customers = @merchant.top_customers
    @items = @merchant.ready_items
  end
end
