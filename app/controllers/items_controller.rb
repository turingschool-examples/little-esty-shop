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
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
    @item.update(item_params)
    redirect_to merchant_item_path(@merchant, @item)   
    flash.notice = "Item has been successfully update"
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create 
    @merchant = Merchant.find(params[:merchant_id])
    @merchant.items.create(item_params)
    redirect_to merchant_items_path(@merchant)
  end 

  private 
  def item_params
    params.permit(:name, :description, :unit_price)    
  end
end
