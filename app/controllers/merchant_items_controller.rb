class MerchantItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    @selling_price = @item.price_convert
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    item.update!(item_params)
    redirect_to merchant_item_path(merchant.id, item.id)
    flash[:success] = "#{item.name} has been successfully updated."
  end

  private

  def item_params
    params.permit(
      :name,
      :description,
      :unit_price
    )
  end
end