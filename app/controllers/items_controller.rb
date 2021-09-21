class ItemsController < ApplicationController
    def index
      @merchant = Merchant.find(params[:merchant_id])
      @merchant_items = @merchant.items
    end

    def show
      @merchant = Merchant.find(params[:merchant_id])
      @item = Item.find_by(params[:item_id])
    end

    def new
      @merchant = Merchant.find(params[:merchant_id])
      @item = Item.new
    end

    def create
      merchant = Merchant.find(params[:merchant_id])
      item = merchant.items.create(item_params)
      if item.save
        redirect_to merchant_items_path(merchant)
        flash[:alert] = "New item for #{merchant.name} has been created."
      else
        redirect_to new_merchant_item_path(merchant)
        flash[:alert] = "Error creating item. Please try again."
      end
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
        params.require(:item).permit(:name, :description, :unit_price, :status)
      end
    end
end
