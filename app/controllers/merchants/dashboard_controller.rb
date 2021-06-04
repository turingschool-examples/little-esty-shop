class Merchants::DashboardController < ApplicationController

  def show 
    @merchant = Merchant.find(params[:merchant_id])
    @shippable_items = @merchant.items.not_yet_shipped
    @top_five_customers = Customer.top_five
  end
end