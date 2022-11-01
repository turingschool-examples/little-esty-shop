class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @merchant_items = @merchant.items
  end

  def show
    @item = Item.find(params[:id])
  end
end