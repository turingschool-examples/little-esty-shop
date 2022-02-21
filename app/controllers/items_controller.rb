class ItemsController < ApplicationController
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
        @item = Item.find(params[:item_id])
        if params[:status] == 'Disable'
            @item.disabled!
            redirect_to "/merchants/#{@item.merchant.id}/items/", notice: "Status changed"
        elsif params[:status]== 'Enable' 
            @item.enabled!
            redirect_to "/merchants/#{@item.merchant.id}/items/", notice: "Status changed"
        else
        @item.update(item_params)
        redirect_to "/merchants/#{@item.merchant.id}/items/#{@item.id}", notice: "Successfully updated"
        end
    end
    private 
      def item_params
        params.permit(:name, :description, :unit_price)
    end

end