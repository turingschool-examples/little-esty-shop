class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
    @favorite_customers = @merchant.top_5_customers
    @packaged_invoice_items = @merchant.items_ready_to_ship
  end

  def update 
    @merchant = Merchant.find(params[:id])
  end
end
