class ItemsController < ApplicationController
    def index
        @merchant = Merchant.find(params[:id])
        @items = @merchant.items
    end

    def show
        @item = Item.find(params[:id])
    end

    def new
        @merchant = Merchant.find(params[:id])
    end

    def create
        @merchant = Merchant.find(params[:id])
        @item = Item.create!(name: params[:name],
            description: params[:description],
            unit_price: params[:unit_price],
            id: find_new_id, merchant: @merchant)
        redirect_to "/merchant/#{@merchant.id}/items"
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
        params.permit(:name, :description, :unit_price, :status, :merchant_id)
    end

    def find_new_id
        Item.last.id + 1
    end
end