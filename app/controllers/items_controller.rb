class ItemsController < ApplicationController
    def index
        @items = Item.where(merchant_id: params[:merchant_id])
    end
end