class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @items = @merchant.items
    #how would i do this with a model method / not instantiating a merchant?
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
      redirect_to "/merchants/#{item.merchant.id}/items/#{item.id}"
      flash[:notice] = "Success: Item information has been updated."
    else
      redirect_to "/merchants/#{item.merchant.id}/items/#{item.id}"
    end
  end
  
  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end
  
  
end
