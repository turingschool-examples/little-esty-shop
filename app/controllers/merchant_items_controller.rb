class MerchantItemsController < ApplicationController

    def index
        @merchant = Merchant.find(params[:merchant_id])

    end

    def show
        @item = Item.find(params[:id])
    end

    def edit
        @item = Item.find(params[:id])
    end

    def update
        item = Item.find(params[:id])
        if item.update(item_params)

          if params[:status].present?
            redirect_to "/merchants/#{item.merchant_id}/items"
            flash[:success] = "Item successfully updated!"
          else
            redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}"
            flash[:success] = "Item successfully updated!"
          end

        else
            redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}/edit"
            flash[:alert] = "Error: #{error_message(item.errors)}"
        end
    end

    def new
        @merchant = Merchant.find(params[:merchant_id])
    end

    def create
        @merchant = Merchant.find(params[:merchant_id])
        item = @merchant.items.create(item_params)
        if item.save
            redirect_to "/merchants/#{@merchant.id}/items"
        else
            redirect_to "/merchants/#{@merchant.id}/items/new"
            flash[:alert] = "Error: Please fill out all required fields!"
        end
        
    end

    private
        def item_params
            params.permit(:name, :description, :unit_price, :status)
        end
end
