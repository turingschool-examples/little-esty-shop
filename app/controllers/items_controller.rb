class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    flash[:success] = "#{item.name} has been successfully updated!"
    redirect_to merchant_item_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end
end
