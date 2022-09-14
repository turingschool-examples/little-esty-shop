class MerchantsController < ApplicationController

  def dashboard
    @merchant = Merchant.find(params[:id])
  end

  def items_index
    @merchant = Merchant.find(params[:id])
  end

  def items_show
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_item = Item.find(params[:merchant_item_id])
  end
end
