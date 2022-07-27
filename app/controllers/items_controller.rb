class ItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items
  end

  def show
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end
end

