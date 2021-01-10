class MerchantItemsController < ApplicationController
  def show
    merchant = Merchant.find(params[:merchant_id])
    @merchant_items = merchant.items
  end
end
