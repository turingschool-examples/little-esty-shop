class MerchantItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @merchant=Merchant.find(params[:merchant_id])
    @item=Item.find(params[:item_id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    flash[:success] = 'You have successfully updated this item'
  end

  private

  def item_params
    params.permit(:id, :description, :unit_price, :status, :created_at, :updated_at, :merchant_id)
  end
end
