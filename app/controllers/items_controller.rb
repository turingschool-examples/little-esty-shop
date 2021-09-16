class ItemsController < ApplicationController
    def index
      @merchant = Merchant.find(params[:merchant_id])
      @merchant_items = @merchant.items
    end

    def show
      @merchant = Merchant.find(params[:merchant_id])
      @item = Item.find_by(params[:item_id])
    end

    def edit
      @merchant = Merchant.find(params[:merchant_id])
      @item = Item.find_by(params[:item_id])
    end

    def update
      require "pry"; binding.pry
      merchant = Merchant.find(params[:merchant_id])
      item = Item.find_by(params[:item_id])
      item.update(item_params)
      redirect_to merchant_item_path(merchant, item)
    end

    private
    def item_params
      params.require(:item).permit(:name, :description, :unit_price)
    end
end
