class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    if item.update(item_params)
      flash[:message] = "Item successfully updated #{error_message(item.errors)}"
      redirect_to "/merchant/#{merchant.id}/items/#{item.id}"
    else
      redirect_to "/merchant/#{merchant.id}/items/#{item.id}/edit"
    end
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
