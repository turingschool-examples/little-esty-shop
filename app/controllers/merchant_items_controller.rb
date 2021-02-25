class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:item_id])
    item.update(item_params)
    if item.save
      flash[:success] = "Item Successfully Updated"

      redirect_to "/merchant/#{merchant.id}/items/#{item.id}"
    end
  end

  private
  def item_params
    params[:item].permit(:name, :description, :unit_price)
  end
end
