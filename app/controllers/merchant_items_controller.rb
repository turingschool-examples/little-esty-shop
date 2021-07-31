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
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    @item.update!(item_params)
    flash[:update_status] = 'Item was successfully updated!'
    redirect_to merchant_item_path(@merchant, @item)
  end

  def update_status
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    @item.update!(item_params)
    redirect_to merchant_items_path(@merchant)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :status)
  end
end
