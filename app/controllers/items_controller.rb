class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items 
  end

  def show 
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])   
    @merchant = @item.merchant
    if params[:disable]
      @item.update(status: params[:disable].to_i)
      redirect_to merchant_items_path(@merchant.id) 
     elsif params[:enable] 
      @item.update(status: params[:enable].to_i)
      redirect_to merchant_items_path(@merchant.id)
    end 
  end
end
