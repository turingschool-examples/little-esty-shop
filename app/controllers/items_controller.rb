class ItemsController < ApplicationController
    def index
        @merchant = Merchant.find(params[:id])
        @items = @merchant.items
    end

    def show
        @item = Item.find(params[:id])
    end

    def edit
        @item = Item.find(params[:id])
    end

    def update
        @item = Item.find(params[:id])
        if params[:status]
            @item.update(item_params)
            redirect_to "/merchant/#{@item.merchant.id}/items"
        else
            @item.update(item_params)
            redirect_to "/merchant/#{@item.merchant.id}/items/#{@item.id}", notice: "Update successful"
        end
    end

    private

    def item_params
        params.permit(:name, :description, :unit_price, :status)
    end
end