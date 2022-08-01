class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    require "pry"; binding.pry
    @item = Item.find(params[:id])
  end

  def edit
  end
end
