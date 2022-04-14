class ItemsController < ApplicationController
    def edit
        @item = Item.find(params[:id])
    end

    def show 
        @item = Item.find(params[:id])
    end
    
    def update  
        Item.update(item_params)
        @item = Item.find(params[:id])
        redirect_to "/items/#{@item.id}", alert: "#{@item.name} has been updated"
    end

    private 

    def item_params 
        params.permit(:name, :description, :unti_price)
    end
end