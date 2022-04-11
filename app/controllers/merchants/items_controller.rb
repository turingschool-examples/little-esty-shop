class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}"
      flash[:success] = "Information Successfully Updated"
    end
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
