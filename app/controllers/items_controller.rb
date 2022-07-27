class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items
  end
end 