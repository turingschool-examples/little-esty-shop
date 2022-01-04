class MerchantItemsController < ApplicationController
  def index
    @merchant_items = Merchant.find(params[:id]).items
  end
end