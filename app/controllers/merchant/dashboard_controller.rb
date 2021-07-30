class Merchant::DashboardController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @top_customers = Customer.top_customers_for_merchant(@merchant.id)
    @pending_items = Item.items_ready_to_ship_by_ordered_date(@merchant.id)
  end

end
