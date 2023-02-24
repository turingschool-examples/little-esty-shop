class Merchants::ItemsController < ApplicationController

  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @items_for_specific_merchant = @merchant.items.all
    @items = @merchant.items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
    @item.update!(item_params)
    redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end
end