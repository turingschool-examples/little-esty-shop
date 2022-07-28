class ItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items
  end

  def show
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def edit
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])    
  end

  def update
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
    @item.update(item_params)
    redirect_to merchant_item_path(@merchant, @item)   
    flash.notice = "Item has been successfully update"
  end

  private 
  def item_params
    params.permit(:name, :description, :unit_price)    
  end
end
