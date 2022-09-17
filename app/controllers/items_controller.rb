class ItemsController < ApplicationController
    def index
        @merchant = Merchant.find(params[:id])
        @items = @merchant.items
    end

    def show
        @item = Item.find(params[:id])
    end
end