class Merchants::ItemsController < ApplicationController

  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @items_for_specific_merchant = @merchant.items
    @items_with_disabled_status = @merchant.items.where(status: "disabled")
    @items_with_enabled_status = @merchant.items.where(status: "enabled")

  end

  def show
    @items = Item.all
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end
end