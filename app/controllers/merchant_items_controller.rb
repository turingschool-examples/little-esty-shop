class MerchantItemsController < ApplicationController
	
  def show
    @merchant = Merchant.find(params[:merchant_id])
		@items = @merchant.items
		@item = Item.find(params[:item_id])
    
  end
end