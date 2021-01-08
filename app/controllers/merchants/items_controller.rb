class Merchants::ItemsController < ApplicationController
  before_action :get_item, only: [:show, :edit]

  def index
    @items = Merchant.find(params[:merchant_id]).items
  end

  def update
    get_item.update(item_params)
    flash.notice = "Item has been updated!"
    redirect_to item_path(params[:id])
  end

  private
  def get_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end
end
