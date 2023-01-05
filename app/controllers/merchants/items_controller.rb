module Merchants
  class ItemsController < ApplicationController
    def index
      @merchant = Merchant.find(params[:merchant_id])
      @items = @merchant.items
    end

    def show
      @merchant = Merchant.find(params[:merchant_id])
      @item = Item.find(params[:id])
      @price = @item.unit_price_to_dollars
    end

    def edit
      @merchant = Merchant.find(params[:merchant_id])
      @item = Item.find(params[:id])
    end

    def update
      merchant = Merchant.find(params[:merchant_id])
      item = Item.find(params[:id])

      if !params[:description]
        item.update(item_params)
        redirect_to merchant_items_path(merchant)
      elsif item.update(item_params)
        flash[:notice] = "Item Updated Successfully"
        redirect_to merchant_item_path(merchant, item)
      else
        flash[:notice] = "Error: All fields must be filled in"
        redirect_to edit_merchant_item_path(merchant, item)
      end
    end

    private

    def item_params
      if params[:current_price]
        params[:unit_price] = Item.dollars_to_unit_price(params[:current_price])
      end
      params.permit(:id, :name, :unit_price, :description, :enabled)
    end
  end
end