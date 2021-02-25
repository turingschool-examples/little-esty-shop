class DashboardController < ApplicationController 
  
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    
    @top_five_cust = @merchant.top_five_customers
    
  end

end