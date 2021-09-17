class ItemsController < ApplicationController

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    if @item.save
      redirect_to item_path(@item)
      flash[:notice] = "Item information has been successfully updated"
    end 
  end

private

  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
