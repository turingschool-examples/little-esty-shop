class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:item_id])
  end

  def edit
    @item = Item.find(params[:item_id])
  end

  # Will need to update to handle edge case of improper unit_price entry
  # at a later date
  # e.g. Typing in as float (3.50) instead of integer (350)
  def update
    item = Item.find(params[:item_id])
    item.update(item_params)
    flash[:notice] = "Item successfully updated!"
    redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}"
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price)
  end
end