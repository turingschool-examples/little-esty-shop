class Merchant::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)

    if params.include?(:enabled)
        if item.enabled == true
          item.update(enabled: false)
          redirect_to "/merchants/#{item.merchant_id}/items"
        else item.enabled == false
          item.update(enabled: true)
          redirect_to "/merchants/#{item.merchant_id}/items"
        end
    else
       item.save
        flash[:success] = "You updated the item!"
        redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}"
    end
  end


  private

  def item_params
      params.fetch(:item, {}).permit(:name, :description, :unit_price, :enabled)
  end
end
