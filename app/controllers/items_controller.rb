class ItemsController < ApplicationController
  def index
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
  end

  def update
    @item = Item.find(params[:id])

    @item.update!(item_params)
    redirect_to "/merchants/items"
  end

  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
