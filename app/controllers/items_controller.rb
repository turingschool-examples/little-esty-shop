class ItemsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @items = Item.where(merchant_id: params[:merchant_id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:item_id])
    item.update(item_params)
    # require 'pry'; binding.pry
    redirect_to "/merchants/#{merchant.id}/items/#{item.id}"
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price)
  end
end