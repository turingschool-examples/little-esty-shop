class Merchants::ItemsController < ApplicationController
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
    @merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to "/merchants/#{@merchant.id}/items"
    flash[:notice] = "Item information successfully updated!"
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
