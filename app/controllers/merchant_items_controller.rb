class MerchantItemsController < ApplicationController
  
  def index
    @merchant = Merchant.find(params[:id])
  end

  def show
    @item = Item.find(params[:item_id])
  end

  def new
  end
end