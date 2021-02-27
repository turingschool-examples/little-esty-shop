class Merchant::ItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      flash.notice = "Item Updated"
    redirect_to merchant_item_path(params[:merchant_id], item)
    else
      flash[:error] = "Fill in unit price with integer, description with statement"
      @item = Item.find(params[:id])
      @merchant = Merchant.find(params[:merchant_id])
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end
end
