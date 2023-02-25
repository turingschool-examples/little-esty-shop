class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @items = @merchant.items
  end

  def show
    @merchant = Merchant.find(params[:id])
    @item = Item.find(params[:item_id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
    @item = Item.find(params[:item_id])
  end

  def update
    merchant = Merchant.find(params[:id])
    item = Item.find(params[:item_id])
    item.update(merchant_item_params)
    redirect_to "/merchants/#{merchant.id}/items/#{item.id}"
  end

  private
  def merchant_item_params
    params.permit(:name, :description, :unit_price)
  end
end