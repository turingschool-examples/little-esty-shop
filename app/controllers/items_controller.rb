class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
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
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    if item.update(item_params)
      flash[:notice] = "Item has been successfully updated"
      redirect_to merchant_item_path(merchant, item)
    else
      flash[:alert] = "Please enter valid data"
      redirect_to edit_merchant_item_path(merchant, item)
    end
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
