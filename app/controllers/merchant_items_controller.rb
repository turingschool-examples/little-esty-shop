class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
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
    item.update(item_params)
    redirect_to "/merchants/#{merchant.id}/items/#{item.id}"
    flash[:alert] = 'Item Successfully Updated'
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end
end
