class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    merchant = Merchant.find(params[:merchant_id])
    @item = merchant.items.find(params[:item_id])
  end
end
