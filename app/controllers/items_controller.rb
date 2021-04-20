class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    @enabled_items = Item.enabled_items
    @disabled_items = Item.disabled_items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    merchant_id = @item.merchant_id
    @merchant = Merchant.find(merchant_id)
    @item.update(item_params)
    redirect_to "/merchants/#{merchant_id}/items"
  end

  private

  def item_params
    params.permit(:name, :status)
  end
end
