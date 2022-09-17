class ItemsController < ApplicationController
  def index
    @items = Item.all
    @merchant = Merchant.find(params[:id])
  end
end
