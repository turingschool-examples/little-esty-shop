class MerchantItemsController < ApplicationController
  def index  
    @items = Merchant.find(params[:merchant_id]).items
  end
end