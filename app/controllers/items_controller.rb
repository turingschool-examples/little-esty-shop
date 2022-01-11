class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items 
  end

  def show 
    @item = Item.find(params[:id])
    @merchant = @item.merchant
  end

  def update
    @item = Item.find(params[:id])   
    @merchant = @item.merchant
    if params[:disable]
      @item.update(status: params[:disable].to_i)
      redirect_to merchant_items_path(@merchant.id) 
    elsif params[:enable] 
      redirect_to merchant_items_path(@merchant.id)
    else 
      @item.update(item_params)
      redirect_to merchant_item_path(params[:merchant_id], params[:id])
      flash[:notice] = "Item has been updated!"
    end 
  end

  def new 
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create 
    item = Item.create(item_params)
    merchant = Merchant.find(params[:merchant_id])
    redirect_to merchant_items_path(merchant.id)
  end

  def edit
    @items = Item.find(params[:id])
    @merchant = @items.merchant
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id, :status)    
  end
end
