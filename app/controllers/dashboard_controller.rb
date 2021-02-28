class DashboardController < ApplicationController 
  
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @top_five_cust = @merchant.top_five_customers
    @not_shipped_items = @merchant.items_not_shipped
  end

end