class Merchant::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_items = @merchant.merchant_items
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to merchant_item_path(item.merchant_id, item.id), notice: "Item successfully updated."
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end
end
