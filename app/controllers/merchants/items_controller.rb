module Merchants
  class ItemsController < ApplicationController
    def index
      @merchant = Merchant.find(params[:merchant_id])
      @items = @merchant.items
    end

    def show
      @item = Item.find(params[:id])
      @price = @item.unit_price_to_dollars
    end
  end
end