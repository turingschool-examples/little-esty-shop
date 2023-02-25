class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @enabled_items = @merchant.items.enabled_items
    @disabled_items = @merchant.items.disabled_items
  end

  def show
    @merchant = Merchant.find(params[:id])
    @item = Item.find(params[:item_id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
    @item = Item.find(params[:item_id])
  end

  def update
    merchant = Merchant.find(params[:id])
    item = Item.find(params[:item_id])
    if params[:status].present?
      item.update(status: params[:status].to_i)
      redirect_to "/merchants/#{merchant.id}/items"
    else
      item.update(merchant_item_params)
      redirect_to "/merchants/#{merchant.id}/items/#{item.id}"
    end
  end
  
  private
  def merchant_item_params
    params.permit(:name, :description, :unit_price)
  end
end