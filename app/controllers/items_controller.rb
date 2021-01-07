class ItemsController < ApplicationController

  def index
    @item = Item.all
  end

  def show
    @items = Item.find(params[:id])
  end
end
