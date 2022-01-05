class MerchantItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    ## below: params[:merchant_id] >> looks for object with that merchant id
    redirect_to merchant_item_path(params[:merchant_id], item)
  end

  private
    def item_params
      params.require(:item).permit(:name, :description, :unit_price)
    end
end
