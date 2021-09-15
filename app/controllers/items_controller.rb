class ItemsController < ApplicationController
    def index
      @merchant = Merchant.find(params[:merchant_id])
      @merchant_items = @merchant.items
    end

    def show
      @item = Item.find_by(params[:item_id])
    end
end
