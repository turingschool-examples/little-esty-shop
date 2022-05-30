class MerchantItemsController < ApplicationController

    def index
        @merchant = Merchant.find(params[:merchant_id])

    end

    def show
        @item = Item.find(params[:item_id])
    end

    def edit
        @item = Item.find(params[:item_id])
    end

    def update
        @merchant = Merchant.find(params[:merchant_id])
        item = Item.find(params[:id])
        item.update(status: params[:status])
        redirect_to "/merchants/#{@merchant.id}/items"
    end
end
