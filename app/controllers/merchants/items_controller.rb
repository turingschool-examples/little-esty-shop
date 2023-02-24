class Merchants::ItemsController < ApplicationController

  def index 

    @merchant = Merchant.find(params[:merchant_id])
    @items_for_specific_merchant = @merchant.items
    @items_with_disabled_status = Item.all.disabled_status_items(params)
    @items_with_enabled_status = Item.all.enabled_status_items(params)
    @five_popular_items = Item.five_popular_items(params[:merchant_id])
    
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

  def new
    # require 'pry'; binding.pry
    @merchant = Merchant.find(params[:merchant_id])
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end


end