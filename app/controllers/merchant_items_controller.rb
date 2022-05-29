class MerchantItemsController < ApplicationController

    def show
        @item = Item.find(params[:item_id])
    end

    def edit
        @item = Item.find(params[:item_id])
    end

end
