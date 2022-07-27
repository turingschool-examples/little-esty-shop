class ItemsController < ApplicationController
    def index
        @items = Item.where(merchant_id: params[:merchant_id])
    end

    def show
        @item = Item.find(params[:id])
    end

    def edit
        @item = Item.find(params[:id])
    end

    def update
        item = Item.find(params[:id])
        item.update(item_params)
        redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}"
        flash.notice = "Item has been successfully updated"
    end
    
    # def update_status
    #     item = Item.find(params[:id])
    #     item.update_status(item_params)
    #     redirect_to request.referrer
    #     flash.notice = "Item status has been successfully updated"
    # end

    private
    def item_params
        params.permit(:name, :unit_price, :description)
    end
end
