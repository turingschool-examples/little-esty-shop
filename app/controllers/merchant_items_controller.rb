class MerchantItemsController < ApplicationController

def show
  @merchant = Merchant.find(params[:merchant_id])
  @item = @merchant.items.find(params[:item_id])
end

def edit
  @merchant = Merchant.find(params[:merchant_id])
  @item = @merchant.items.find(params[:item_id])
end

end
