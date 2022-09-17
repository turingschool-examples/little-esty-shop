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
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    if params[:active_status] == "disabled"
      item_status = Item.find(params[:id])
      item_status.active_status = "disabled"
      item_status.save
      redirect_to(merchant_items_path(merchant))
    elsif params[:active_status] == "enabled"
      item_status = Item.find(params[:id])
      item_status.active_status = "enabled"
      item_status.save
      redirect_to(merchant_items_path(merchant))
    else
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to(merchant_item_path(merchant, item))
    end 
  end
private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :active_status)
  end

end
