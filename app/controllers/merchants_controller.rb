class MerchantsController < ApplicationController

  def dashboard
    @merchant = Merchant.find(params[:merchant_id]) 
    @mech_unshipped_items = @merchant.unshipped_items
    @mech_top_5_customers = @merchant.mech_top_5_successful_customers
  end

end
