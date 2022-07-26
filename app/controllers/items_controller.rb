class ItemsController < ApplicationController
    def index
        @items = Item.where(merchant_id: params[:merchant_id])
    end

    def show
        # binding.pry
        @item = Item.find(params[:id])
    end
end