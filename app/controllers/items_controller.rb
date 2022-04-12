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
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
    @item.update(item_params)
    redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
  end

  private
  def item_params
    params.permit(:id, :name, :unit_price, :description, :enabled)
  end
end
