class ItemsController < ApplicationController
  def index
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
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])

    if @item.update!(item_params)
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
      flash[:alert] = "Successfully Updated"
    else
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}/edit"
      flash[:alert] = "Item Not Updated"
    end
  end

  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
