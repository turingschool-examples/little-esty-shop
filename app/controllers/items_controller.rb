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
      merchant = Merchant.find(params[:merchant_id])
      item = Item.find(params[:id])
      if params[:item]
        item.update(item_params)
        redirect_to merchant_item_path(merchant, item)
      else
        item.update(item_params)
        redirect_to merchant_items_path(merchant)
      end
      flash[:alert] = "Item has been successfully updated"
    end

    private
    
    def item_params
      if not params[:item]
        params.permit(:status ,:name, :description, :unit_price)
      else
        params.require(:item).permit(:name, :description, :unit_price)
      end
    end
end
