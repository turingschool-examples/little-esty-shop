class ItemsController < ApplicationController
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    if params[:merchant_id]
      @merchant.items 
    end
  end
  
  def show
    @item = Item.find(params[:id])
  end
  def update 
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    @item.update(status: params[:status])
    @item.save 
    redirect_to "/merchants/#{@merchant.id}/items"

  end

end