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

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update!(item_params)
    
    flash.notice = "The Information Has Successfully Updated"
    redirect_to "/merchants/#{@item.merchant.id}/items/#{@item.id}"
  end

  private
  def item_params
    params.permit(:name,:description,:unit_price)
  end
end