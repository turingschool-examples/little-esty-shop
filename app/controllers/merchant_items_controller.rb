class MerchantItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:id])
  end

  def show
    @merchant = Merchant.find(params[:id])
    @item = @merchant.items.find(params[:item_id])
  end
end
