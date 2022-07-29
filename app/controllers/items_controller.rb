class ItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    merchant = Merchant.find(params[:merchant_id])
    item.update(availability: params[:availability])
    redirect_to merchant_items_path(merchant)   
    flash.notice = "Item has been successfully update"
  end

  private 
  def item_params
    params.permit(:name, :description, :unit_price, :availability)    
  end
end
