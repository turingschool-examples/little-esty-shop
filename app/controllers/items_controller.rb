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
        if params[:status] == 'enabled'
            item.enabled!
            redirect_to request.referrer
            flash.notice = "#{item.name} has been enabled"
        elsif params[:status] == 'disabled'
            item.disabled!
            redirect_to request.referrer
            flash.notice = "#{item.name} has been disabled"
        else
            item.update(item_params)
            redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}"
            flash.notice = "#{item.name} has been successfully updated"
        end
    end

    private
    def item_params
        params.permit(:name, :unit_price, :description, :status)
    end
end
