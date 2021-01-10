class MerchantItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
    if @item.enabled
      @item.enabled = false
      @item.save
    else
      @item.enabled = true
      @item.save
    end
    redirect_to "/merchant/#{@merchant.id}/items"
  end
end
