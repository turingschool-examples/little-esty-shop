class Merchants::ItemsController < ApplicationController

  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @items_for_specific_merchant = @merchant.items.all
    @items = @merchant.items
  end

  def show
    @items = Item.all
  end
end