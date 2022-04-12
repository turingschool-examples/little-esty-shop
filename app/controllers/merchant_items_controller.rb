class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @enabled_items = @merchant.items.where(status: :enabled)
    @disabled_items = @merchant.items.where(status: :disabled)
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
    @item.status = params[:status]
    @item.save
    redirect_to merchant_items_path
  end

  def create
  end

  def destroy
  end
end
