class ItemsController < ApplicationController
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    if params[:merchant_id]
      @merchant.items 
    end
  end

  def show
    @item = Item.find(params[:id])
    # require 'pry';binding.pry
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to "/merchants/#{@item.merchant.id}/items/#{@item.id}"
  end
end