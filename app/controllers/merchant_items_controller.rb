class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @merchant_items = @merchant.items
  end
end