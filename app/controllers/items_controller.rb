class ItemsController < ApplicationController
  
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @enabled_items = @merchant.items.where(availability: "enable")
    @disabled_items = @merchant.items.where(availability: "disable")
  end

  def show
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    merchant = Merchant.find(params[:merchant_id])
    if params[:availability].present?
      item.update(availability: params[:availability])
      redirect_to merchant_items_path(merchant)
    else
      item.update(item_params)
      redirect_to merchant_item_path(merchant, item)
      flash[:success] = "Item has been successfully updated"
    end 
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create 
    merchant = Merchant.find(params[:merchant_id])
    merchant.items.create(item_params)
    redirect_to merchant_items_path(merchant)
  end 

  private 
  def item_params
    params.permit(:name, :description, :unit_price, :availability)    
  end
end
