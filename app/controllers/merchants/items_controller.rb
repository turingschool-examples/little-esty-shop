module Merchants
  class ItemsController < ApplicationController
    def index
      @merchant = Merchant.find(params[:merchant_id])
      @items = @merchant.items
    end

    def show
      @merchant = Merchant.find(params[:merchant_id])
      @item = Item.find(params[:id])
      @price = @item.unit_price_to_dollars
    end

    def edit
      @merchant = Merchant.find(params[:merchant_id])
      @item = Item.find(params[:id])
    end

    def update
      
    end
  end
end