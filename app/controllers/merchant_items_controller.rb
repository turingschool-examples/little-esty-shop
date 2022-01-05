class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = Item.all.where(merchant: params[:merchant_id])
  end

  def show
    @item = Item.find(params[:id])
  end
end
