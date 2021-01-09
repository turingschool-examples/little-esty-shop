class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    find_item_and_merchant
  end

  def edit
    find_item_and_merchant
  end

  def update
    find_item_and_merchant
    @item.update(item_params)
    flash.notice = "Succesfully Updated Item Info!"
    redirect_to merchant_item_path(@merchant, @item)
  end


  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end

  def find_item_and_merchant
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end
end
