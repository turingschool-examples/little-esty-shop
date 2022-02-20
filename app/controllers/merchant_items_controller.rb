class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
  end

  def show
    @merchant = Merchant.find(params[:id])
    @item = Item.find(params[:item_id])
  end

  def edit

  end
end
