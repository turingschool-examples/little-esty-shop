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

  def new
    @merchant = Merchant.find(params[:merchant_id])
    item = Item.new
    item.save
    redirect_to merchant_items_path(@merchant)
  end

  def create

  end
end
