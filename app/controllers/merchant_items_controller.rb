class MerchantItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit

  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    item = @merchant.items.find(params[:id])
    if params[:enable] != nil
      item.update(status: 1)
    elsif params[:disable] != nil
      item.update(status: 0)
    end
    redirect_to merchant_items_path(@merchant)
  end
end
