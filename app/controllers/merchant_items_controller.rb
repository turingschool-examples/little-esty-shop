class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
  end

  def show
    @item = Item.find(params[:item_id])
  end

  def edit
    @item = Item.find(params[:item_id])
  end

  def update
    item = Item.find(params[:item_id])
    item.update!(item_params)
      flash[:alert] = "Information has been successfully updated"
    redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}"
  end

  private
    def item_params
      params.permit(:name, :description, :unit_price)
    end
end
