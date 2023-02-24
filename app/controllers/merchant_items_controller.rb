class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    @item = Item.find(params[:item_id])
    if params[:status] == "disabled"
      @item.update(status: 1)
      redirect_to "/merchant/#{@merchant.id}/items"
    else
      @item.update(status: 0)
      redirect_to "/merchant/#{@merchant.id}/items"
    end
  end
end