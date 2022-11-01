class ItemsController < ApplicationController 
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @enabled_items = @merchant.enabled_items
    @disabled_items = @merchant.disabled_items 
  end

  def show 
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit 
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end
end