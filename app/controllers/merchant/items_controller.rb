class Merchant::ItemsController < ApplicationController
  def index
    # binding.pry
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:id])
  end
end
