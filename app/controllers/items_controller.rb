class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end
end