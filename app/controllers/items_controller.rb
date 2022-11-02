class ItemsController < ApplicationController
  def index
    # require 'pry'; binding.pry
    if params.has_key? 'merchant_id'
      @merchant = Merchant.find(params[:merchant_id])
    end
  end

  def show
    @item = Item.find(params[:id])
  end
end
