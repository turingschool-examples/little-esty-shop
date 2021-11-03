class ItemsController < ApplicationController
  def index
    @items = Item.find(params[:merchant_id])
  end
end
