class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
  end

  def edit
    
  end
end
