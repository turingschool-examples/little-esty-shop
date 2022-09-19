class ItemsController < ApplicationController
  def index
    @items = Item.all
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:id])
  end
end
