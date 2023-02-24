class Merchants::ItemsController < ApplicationController

  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @items_for_specific_merchant = @merchant.items
    @items_with_disabled_status = Item.all.disabled_status_items(params)
    @items_with_enabled_status = Item.all.enabled_status_items(params)
    @five_popular_items = Item.five_popular_items(params[:merchant_id])
    
  end

  def show
    @items = Item.all
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end
end