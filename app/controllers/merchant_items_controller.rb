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
        item = Item.find(params[:item_id])
        if item.update(item_params)
            redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}"
            flash[:success] = "Item successfully updated!"
        else
            redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}/edit"
            flash[:alert] = "Error: #{error_message(item.errors)}"
        end
    end

    private
        def item_params
            params.permit(:name, :description, :unit_price)
        end
end
