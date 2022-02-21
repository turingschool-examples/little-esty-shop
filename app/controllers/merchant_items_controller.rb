class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
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
    item.update(item_params)

    redirect_to "/merchants/#{merchant.id}/items/#{item.id}", alert: "Notice: Item successfully updated."
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
