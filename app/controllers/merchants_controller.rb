class MerchantsController < ApplicationController

  def dashboard
    @merchant = Merchant.find(params[:merchant_id]) 
    @mech_top_5_customers = @merchant.mech_top_5_successful_customers
    @items_not_shipped = @merchant.items.unshipped_items
  end

end
