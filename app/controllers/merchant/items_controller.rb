class Merchant::ItemsController < ApplicationController
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
    item = Item.find(params[:id])
    item.update(item_params)
    if item.save
      flash[:success] = "You updated the item!"
      redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}"
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end
end
