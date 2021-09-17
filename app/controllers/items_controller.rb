class ItemsController < ApplicationController
  def new

  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if params[:enable].nil? && params[:disable].nil?
      item.update(item_params)
      flash[:success] = "#{item.name} has been successfully updated!"
      redirect_to merchant_item_path
    else
      item.update_status!(params[:enable], params[:disable])
      redirect_to merchant_items_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end
end
