class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:item_id])
  end
end